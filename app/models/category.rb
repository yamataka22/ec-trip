class Category < ApplicationRecord
  has_many :child_categories, class_name: 'Category', foreign_key: 'root_category_id', dependent: :destroy
  belongs_to :root_category, class_name: 'Category'

  has_many :category_items, dependent: :destroy
  has_many :items, through: :category_items

  validates :name, presence: true

  # scope :root_categories, -> { where(root_category_id: nil) }

  def self.create_with_auto_sequence(params)
    category = Category.new(params)
    category.set_auto_sequence
    category.save
    category
  end

  def update_with_auto_sequence
    if self.root_category_id_changed?
      # 所属するRootカテゴリが変更された場合、シーケンスを採番しなおす
      self.set_auto_sequence
    end
    self.save
  end

  def sequence_up
    before_category = Category.where(root_category: self.root_category).where('sequence < ?', self.sequence).order(:sequence).last

    if before_category
      org_sequence = self.sequence
      self.sequence = before_category.sequence
      self.save!
      before_category.sequence = org_sequence
      before_category.save!
      true
    else
      false
    end
  end

  def root?
    self.root_category_id.nil?
  end

  def self.sorted_all(include_items: false)
    categories = []
    root_categories = Category.where(root_category_id: nil)
    if include_items
      root_categories = root_categories.includes(:items, child_categories: [:items])
    else
      root_categories = root_categories.includes(:child_categories)
    end
    root_categories = root_categories.order(:sequence)
    root_categories.each do |root_category|
      categories.push root_category
      categories.concat root_category.child_categories.sort_by{|child| child.sequence}
    end
    categories
  end

  def set_auto_sequence
    self.sequence = Category.where(root_category_id: root_category_id).maximum(:sequence).to_i + 1
  end

  def self.root_categories
    Category.where(root_category_id: nil).includes(:child_categories).order(:sequence)
  end

end
