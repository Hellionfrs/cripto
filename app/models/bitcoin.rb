class Bitcoin < ApplicationRecord
  validates :hash, presence: true
  validates :block, presence: true
  
end
