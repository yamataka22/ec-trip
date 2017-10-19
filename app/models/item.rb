class Item < ApplicationRecord
  belongs_to :category
  belongs_to :caption_image, class_name: 'Image'

  enum status: {unpublished: 0, selling: 1, end_of_sell: 2}

  validates :name, presence: true
  validates :stock, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :price, numericality: { only_integer: true, greater_than: 1 }, allow_nil: true

  validates :description, presence: true, on: :publish
  validates :content, presence: true, on: :publish
  validates :stock, presence: true, on: :publish
  validates :price, presence: true, on: :publish

  scope :published, -> { where(status: [:selling, :end_of_sell]) }
  scope :selling, -> { where(status: :selling) }
end
