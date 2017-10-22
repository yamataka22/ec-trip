class Category < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true

  def self.create(params)
    category = Category.new(params)
    category.sequence = Category.maximum(:sequence).to_i + 1
    category.save
    category
  end

  def change_sequence(type)
    if type == :up
      side_category = Category.where('sequence < ?', self.sequence).order(:sequence).last
    else
      side_category = Category.where('sequence > ?', self.sequence).order(:sequence).first
    end
    if side_category
      org_sequence = self.sequence
      self.sequence = side_category.sequence
      self.save!
      side_category.sequence = org_sequence
      side_category.save!
      true
    else
      false
    end
  end

end
