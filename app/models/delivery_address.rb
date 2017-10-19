class DeliveryAddress < ApplicationRecord
  belongs_to :member
  belongs_to :prefecture

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone, presence: true
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :address1, presence: true
end
