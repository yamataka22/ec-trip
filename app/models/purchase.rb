class Purchase < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :member
  has_many :details, class_name: 'PurchaseDetail'
  belongs_to_active_hash :delivery_prefecture, class_name: 'Prefecture'
  belongs_to_active_hash :invoice_prefecture, class_name: 'Prefecture'

  accepts_nested_attributes_for :details

  attr_accessor :use_another_address
  attr_reader :credit_card_id, :delivery_address_id, :credit_card, :delivery_address

  validates :guest_email, presence: true, if: -> { self.member.blank? }
  validates :invoice_last_name, presence: true
  validates :invoice_first_name, presence: true
  validates :invoice_phone, presence: true
  validates :invoice_postal_code, presence: true
  validates :invoice_prefecture_id, presence: true
  validates :invoice_address1, presence: true
  validates :delivery_last_name, presence: true, if: :use_another_address?
  validates :delivery_first_name, presence: true, if: :use_another_address?
  validates :delivery_phone, presence: true, if: :use_another_address?
  validates :delivery_postal_code, presence: true, if: :use_another_address?
  validates :delivery_prefecture_id, presence: true, if: :use_another_address?
  validates :delivery_address1, presence: true, if: :use_another_address?
  validates :details, presence: true

  def set_attribute

    set_invoice
    set_delivery

    build_detail_from_cart
    set_amount

  end

  def set_guest_attribute
    build_detail_from_cart
    copy_invoice_to_delivery unless use_another_address?
    set_amount
  end

  def new_order(stripe_token = nil)
    if self.invalid? || !stock_reserve
      return false
    end

    set_amount
    set_current_item_info

    if self.member.present?
      stripe_charge = StripeOperate.charge_create(
          self.member.stripe_customer_id,
          self.credit_card.stripe_card_id,
          self.total_amount)
    else
      stripe_charge = StripeOperate.token_charge_create(
          stripe_token,
          self.cart_session_id,
          self.total_amount)
    end

    unless stripe_charge
      stock_rollback
      self.errors.add(:base, '指定頂いたクレジットカードでの決済ができません。カード会社にご確認ください。')
      return false
    end

    self.stripe_charge_id = stripe_charge.id
    self.purchased_date = Date.current
    self.save!

    cart_clear
    true

  end

  def total_amount
    self.item_amount + self.tax + self.delivery_fee
  end

  def invoice_address
    self.member.addresses.find_by(invoice: true)
  end

  def delivery_address
    self.member.addresses.find{|address| address.id == self.delivery_address_id.to_i}
  end

  def credit_card
    self.member.credit_cards.find{|card| card.id == self.credit_card_id.to_i}
  end

  def delivery_address_id=(value)
    if value.present? && self.member.addresses.find(value)
      @delivery_address_id = value
    end
  end

  def credit_card_id=(value)
    if value.present? && self.member.credit_cards.find(value)
      @credit_card_id = value
    end
  end

  def set_amount
    self.item_amount = 0
    self.details.each do |detail|
      self.item_amount += detail.item.price * detail.quantity
    end
    # TODO
    self.delivery_fee = 0
    self.tax = Util.calc_tax(self.item_amount + self.delivery_fee)
  end

  def purchase_no
    "P#{self.created_at.strftime('%y')}#{format('%04d', self.id)}"
  end

  def delivery_full_name
    "#{self.delivery_last_name} #{self.delivery_first_name}"
  end

  def invoice_full_name
    "#{self.invoice_last_name} #{self.invoice_first_name}"
  end

  def build_detail_from_cart
    self.details = []
    Cart.includes(:item).search(self.member, self.cart_session_id).each do |cart|
      self.details.build(
          item_id: cart.item.id,
          quantity: cart.quantity
      )
    end
  end

  def set_current_item_info
    self.details.each do |detail|
      detail.item_name = detail.item.name
      detail.price = detail.item.price
    end
  end

  def use_another_address?
    self.member.blank? && self.use_another_address.present? ||
        self.member.present? && self.invoice_address.id != self.delivery_address_id.to_i
  end

  private
  def set_invoice
    invoice_address = self.member.invoice_address
    self.invoice_last_name = invoice_address.last_name
    self.invoice_first_name = invoice_address.first_name
    self.invoice_phone = invoice_address.phone
    self.invoice_postal_code = invoice_address.postal_code
    self.invoice_prefecture_id = invoice_address.prefecture_id
    self.invoice_address1 = invoice_address.address1
    self.invoice_address2 = invoice_address.address2
  end

  def set_delivery
    delivery_address = self.delivery_address
    self.delivery_last_name = delivery_address.last_name
    self.delivery_first_name = delivery_address.first_name
    self.delivery_phone = delivery_address.phone
    self.delivery_postal_code = delivery_address.postal_code
    self.delivery_prefecture_id = delivery_address.prefecture_id
    self.delivery_address1 = delivery_address.address1
    self.delivery_address2 = delivery_address.address2
  end

  def copy_invoice_to_delivery
    self.delivery_last_name = self.invoice_last_name
    self.delivery_first_name = self.invoice_first_name
    self.delivery_phone = self.invoice_phone
    self.delivery_postal_code = self.invoice_postal_code
    self.delivery_prefecture_id = self.invoice_prefecture_id
    self.delivery_address1 = self.invoice_address1
    self.delivery_address2 = self.invoice_address2
  end

  def stock_reserve
    begin
      ActiveRecord::Base.transaction do
        details.each do |detail|
          detail.item.increment!(:stock_quantity, -1 * detail.quantity)
          if detail.item.stock_quantity < 0
            raise "申し訳ございませんが「#{detail.item.name}」は在庫切れとなりました。決済はキャンセルされました。"
          end
        end
      end
    rescue => e
      errors.add(:base, e.message)
      return false
    end
  end

  def stock_rollback
    self.details.each do |detail|
      detail.item.increment!(:stock_quantity, detail.quantity)
    end
  end

  def cart_clear
    Cart.search(self.member, self.cart_session_id).delete_all
  end
end
