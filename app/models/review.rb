class Review < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  belongs_to :product
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
