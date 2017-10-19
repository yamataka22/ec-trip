class Purchase < ApplicationRecord
  belongs_to :member
  belongs_to :credit_card
  has_many :purchase_details
end
