require 'rails_helper'

RSpec.describe Review, type: :model do
    it { is_expected.to belong_to :restaurant }
    it { is_expected.to belong_to :user }

    it 'cannot rate more than 5' do
      review = Review.create(rating: 7)
      expect(review).to have(1).error_on(:rating)
      expect(review).not_to be_valid
    end
end
