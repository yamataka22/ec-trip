class Category < ApplicationRecord
  before_destroy :can_destroy?
  has_many :items

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

  def can_destroy?
    return true if self.items.count == 0
    errors.add :base, '対象のカテゴリには商品が登録されているため、削除できません'
    false
  end
end
