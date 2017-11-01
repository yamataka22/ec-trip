class Contact < ApplicationRecord
  validates :body, presence: true, length: {maximum: 500}
  validates :email, presence: true
  validates :last_name, presence: true

  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
