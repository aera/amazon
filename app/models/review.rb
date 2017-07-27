class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user  

  validates :rating, presence: true, inclusion: { in: 1..5 }

  def vote_total
		votes.up.count - votes.down.count
	end

end
