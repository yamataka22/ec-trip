class Slider < ApplicationRecord
  belongs_to :image

  validates :image_id, presence: true, if: :published?

  enum caption_position: {left: 0, center: 1, right: 2}
  enum caption_color: {black: 0, white: 1}
end
