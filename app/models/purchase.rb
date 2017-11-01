class Purchase < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :member
  belongs_to :credit_card
  has_many :details, class_name: 'PurchaseDetail'
  belongs_to_active_hash :delivery_prefecture, class_name: 'Prefecture'
  belongs_to_active_hash :invoice_prefecture, class_name: 'Prefecture'

  accepts_nested_attributes_for :details

  attr_accessor :credit_card_id, :invoice_address_id, :delivery_address_id

  validates :invoice_last_name, presence: true
  validates :invoice_first_name, presence: true
  validates :invoice_phone, presence: true
  validates :invoice_postal_code, presence: true
  validates :invoice_prefecture_id, presence: true
  validates :invoice_address1, presence: true
  validates :delivery_last_name, presence: true
  validates :delivery_first_name, presence: true
  validates :delivery_phone, presence: true
  validates :delivery_postal_code, presence: true
  validates :delivery_prefecture_id, presence: true
  validates :delivery_address1, presence: true
  validates :details, presence: true

  def set_attribute(delivery_address_id, credit_card_id)

    set_invoice

    if delivery_address_id.present?
      set_delivery(delivery_address_id)
    else
      set_delivery(self.member.main_address.id)
    end

    if credit_card_id.present?
      set_credit_card(credit_card_id)
    else
      set_credit_card(self.member.main_credit_card.id)
    end

    build_detail
    set_amount
  end

  def new_order
    if self.invalid? || !stock_reserve
      return false
    end

    set_amount

    credit_card = self.member.credit_cards.find(self.credit_card_id)
    self.credit_card_info = credit_card.card_info

    stripe_charge = StripeOperate.charge_create(self.member.stripe_customer_id, credit_card.stripe_card_id, self.total_amount)
    unless stripe_charge
      stock_rollback
      self.errors.add(:base, '指定頂いたクレジットカードでの決済ができません。カード会社にご確認ください。')
      return false
    end

    self.stripe_charge_id = stripe_charge.id
    self.save!

    cart_clear
    true

  end

  def total_amount
    self.item_amount + self.tax + self.delivery_fee
  end

  def invoice_address
    self.member.addresses.find(self.invoice_address_id)
  end

  def delivery_address
    self.member.addresses.find(self.delivery_address_id)
  end

  def set_amount
    self.item_amount = 0
    self.details.each do |detail|
      self.item_amount += detail.item.price * detail.quantity
    end
    # TODO
    self.delivery_fee = 350
    self.tax = Util.calc_tax(self.item_amount + self.delivery_fee)
  end

  def purchase_no
    "#{self.created_at.year}-#{format('%07d', self.id)}"
  end

  def delivery_full_name
    "#{self.delivery_last_name} #{self.delivery_first_name}"
  end

  def invoice_full_name
    "#{self.invoice_last_name} #{self.invoice_first_name}"
  end

  private
  def set_invoice
    invoice_address = self.member.invoice_address
    self.invoice_address_id = invoice_address.id
    self.invoice_last_name = invoice_address.last_name
    self.invoice_first_name = invoice_address.first_name
    self.invoice_phone = invoice_address.phone
    self.invoice_postal_code = invoice_address.postal_code
    self.invoice_prefecture_id = invoice_address.prefecture_id
    self.invoice_address1 = invoice_address.address1
    self.invoice_address2 = invoice_address.address2
  end

  def set_delivery(delivery_address_id)
    delivery_address = self.member.delivery_addresses.find(delivery_address_id)
    self.delivery_address_id = delivery_address.id
    self.delivery_last_name = delivery_address.last_name
    self.delivery_first_name = delivery_address.first_name
    self.delivery_phone = delivery_address.phone
    self.delivery_postal_code = delivery_address.postal_code
    self.delivery_prefecture_id = delivery_address.prefecture_id
    self.delivery_address1 = delivery_address.address1
    self.delivery_address2 = delivery_address.address2
  end

  def set_credit_card(credit_card_id)
    self.credit_card_info = self.member.credit_cards.find(credit_card_id).card_info
    self.credit_card_id = credit_card_id
  end

  def build_detail
    self.details = []
    self.member.carts.each do |cart|
      item = cart.item
      self.details.build(
          item_id: item.id,
          item_name: item.name,
          price: item.price,
          quantity: cart.quantity
      )
    end
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
    self.details.each do |detail|
      Cart.where(member: member, item_id: detail.item_id).delete_all
    end
  end
end
