class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  # def edit_as(user)
  #   return false if user_did_not_create_restaurant
  #   true
  # end

end
