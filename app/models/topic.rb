class Topic < ApplicationRecord
  validates :title, presence: true
end
