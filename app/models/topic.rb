class Topic < ApplicationRecord
  validates :text, presence: true
end
