class Preview < ApplicationRecord
  belongs_to :manager
  serialize :content
end
