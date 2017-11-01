class StaticPage < ApplicationRecord
  include TinymceConcern
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true

  before_validation :set_tinymce_images_path if Rails.env.development?

  before_destroy :can_destroy?

  attr_accessor :preview

  private
  def set_tinymce_images_path
    TinymceConcern.set_images_path(self.content)
  end

  def can_destroy?
    return true unless %w(about commercial privacy terms).include?(self.name)
    errors.add :base, '対象のページは削除できません'
    false
  end
end
