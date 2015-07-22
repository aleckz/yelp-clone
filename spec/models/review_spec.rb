require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant}

  it 'should be destroyed when restaurant is destroyed' do
    kfc = Restaurant.create name:'KFC'
    kfc.reviews.create(thoughts: 'so so')
    kfc.destroy
    expect(Review.find_by thoughts: 'so so').to equal nil
  end
end
