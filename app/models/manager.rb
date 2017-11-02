class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true

  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
