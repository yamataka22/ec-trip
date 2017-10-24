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
  has_many :addresses

  has_one :main_address, class_name: 'Address'
  has_one :main_credit_card, class_name: 'CreditCard'

  # accepts_nested_attributes_for :addresses
  # accepts_nested_attributes_for :credit_cards

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
    self.carts.sum(:quantity)
  end

  def carts_sub_total
    amount = 0
    self.carts.each do |cart|
      amount += cart.item.price * cart.quantity
    end
    amount
  end

  def total_cart_amount
    amount = 0
    self.carts.each do |cart|
      amount = amount + cart.item.price * cart.quantity
    end
    amount
  end

  def main_credit_card
    self.credit_cards.find_by(main: true)
  end

  def info_collected?
    self.last_name.present? &&
        self.first_name.present? &&
        self.postal_code.present? &&
        self.address1.present? &&
        self.phone.present?
  end

end
