class Review < ActiveRecord::Base
   belongs_to :restaurant
   belongs_to :user

   validates :rating, numericality: { only_integer: true, less_than_or_equal_to: 5}
   validates :user, uniqueness: { scope: :restaurant }
  #  validates :user_id, presence: true
end
