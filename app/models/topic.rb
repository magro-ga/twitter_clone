class Topic < ApplicationRecord
  validates :titulo, presence: true, uniqueness: true
  has_many :tweets
end
