require 'rails_helper'

RSpec.describe Review, type: :model do
    it { is_expected.to belong_to :restaurant }
    it { is_expected.to belong_to :user }

    it 'cannot rate more than 5' do
      review = Review.create(rating: 7)
      expect(review).to have(1).error_on(:rating)
      expect(review).not_to be_valid
    end

    describe 'build with user in params' do
      let(:user) { User.create(email: "3oolex@email.com", password: "8characters") }
      let(:restaurant) { Restaurant.create(name: "Nandos") }
      let(:review_params) { { thoughts: 'yes', rating: 3, user_id: user.id }  }

      subject(:review) { restaurant.reviews.create(review_params) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
      end
    end
end
