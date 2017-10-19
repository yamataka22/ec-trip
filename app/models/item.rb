class Item < ApplicationRecord
  belongs_to :category
  belongs_to :caption_image, class_name: 'Image'
  has_many :purchase_details
  has_many :favorites

  enum status: {unpublished: 0, selling: 1, end_of_sell: 2}

  validates :name, presence: true
  validates :stock, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :price, numericality: { only_integer: true, greater_than: 1 }, allow_nil: true

  validates :description, presence: true, on: :publish
  validates :about, presence: true, on: :publish
  validates :stock, presence: true, on: :publish
  validates :price, presence: true, on: :publish
end
