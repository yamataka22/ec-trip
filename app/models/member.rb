class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  belongs_to :profile_image, class_name: 'Image'

  has_many :favorites
  has_many :purchases
  has_many :carts
  has_many :credit_cards
  has_many :delivery_addresses

  accepts_nested_attributes_for :delivery_addresses
  accepts_nested_attributes_for :credit_cards

  validates_uniqueness_of :account_name, :case_sensitive => false
  validates :account_name, presence: true, length: {maximum: 15}

  validates :last_name, presence: true, on: :info_collect
  validates :first_name, presence: true, on: :info_collect
  validates :phone, presence: true, on: :info_collect
  validates :postal_code, presence: true, on: :info_collect
  validates :address1, presence: true, on: :info_collect

  def self.from_facebook_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.from_twitter_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def counts_cart
    Cart.where(member: self).sum(:volume)
  end

  def carts_sub_total
    amount = 0
    self.carts.each do |cart|
      amount += cart.product.price * cart.volume
    end
    amount
  end

  def total_cart_amount
    amount = 0
    carts = Cart.where(member_id: self.id)
    carts.each do |cart|
      amount = amount + cart.product.price * cart.volume
    end
    amount
  end

  def main_delivery_address
    self.delivery_addresses.order(main: :desc, id: :asc).first
  end

  def main_credit_card
    self.credit_cards.order(main: :desc, id: :asc).first
  end

  def info_collected?
    self.last_name.present? &&
        self.first_name.present? &&
        self.postal_code.present? &&
        self.address1.present? &&
        self.phone.present?
  end

  def update!
    self.delivery_addresses.each{ |address| address.mark_for_destruction if address.is_member_info? }
    if self.use_as_delivery_address?
      address = self.delivery_addresses.build(last_name: self.last_name, first_name: self.first_name, phone: self.phone,
                                              postal_code: self.postal_code, address1: self.address1,
                                              address2: self.address2, is_member_info: true)
      address.main = true if self.delivery_addresses.where(is_member_info: false, main: true).count == 0
    end
    self.save!
  end
end
