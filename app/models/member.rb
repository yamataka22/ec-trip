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

  # accepts_nested_attributes_for :addresses
  # accepts_nested_attributes_for :credit_cards

  validates_uniqueness_of :account_name, :case_sensitive => false
  validates :account_name, presence: true, length: {maximum: 15}

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

  def invoice_address
    self.addresses.find_by(invoice: true)
  end

  def delivery_addresses
    self.addresses.where(delivery: true)
  end

  def main_credit_card
    if self.main_credit_card_id.present?
      main_card = self.credit_cards.find_by(id: self.main_credit_card_id)
    else
      main_card = nil
    end
    if main_card.nil?
      main_card = self.credit_cards.all.order(:id).first
    end
    main_card
  end

  def main_address
    if self.main_address_id.present?
      main_address = self.delivery_addresses.find_by(id: self.main_address_id)
    else
      main_address = nil
    end
    if main_address.nil?
      main_address = self.delivery_addresses.all.order(:id).first
    end
    main_address
  end

  def leave
    self.skip_reconfirmation!
    self.update_column(:email, "#{self.email}.leaved#{Util.random_string(10)}")

    self.uid = "#{self.uid}?leaved#{Util.random_string(10)}" if self.uid.present?
    self.password = SecureRandom.uuid
    self.leave_at = Time.now
    self.save!
  end

end
