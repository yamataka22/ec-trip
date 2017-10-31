class StaticPage < ApplicationRecord
  include TinymceConcern
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true

  before_validation :set_tinymce_images_path if Rails.env.development?

  attr_accessor :preview

  private
  def set_tinymce_images_path
    TinymceConcern.set_images_path(self.content)
  end
end
