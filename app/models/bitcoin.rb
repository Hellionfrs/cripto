class Bitcoin < ApplicationRecord
  validates :body, presence: true
  validates :block, presence: true
  
end
