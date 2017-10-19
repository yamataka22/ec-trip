class Contact < ApplicationRecord
  validates :about, presence: true, length: {maximum: 500}
  validates :email, presence: true
  validates :first_name, presence: true
end
