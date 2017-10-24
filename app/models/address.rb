class Address < ApplicationRecord
  belongs_to :member
  belongs_to :prefecture

  accepts_nested_attributes_for :member

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone, presence: true
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :address1, presence: true

  def invoice_create
    self.invoice = true
    if self.valid?
      self.save!
      self.member.main_address_id = self.id
      self.member.save
      true
    else
      false
    end
  end
end
