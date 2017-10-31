class CategoryItem < ApplicationRecord
  belongs_to :category
  belongs_to :item

  attr_accessor :enable
end
