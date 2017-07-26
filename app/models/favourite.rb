class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :product_id, uniqueness: {
    scope: :user_id
  #  message: ->(object, data) do
  #    "You've already liked this #{data[:attribute].downcase}"
  #  end
  }
end
