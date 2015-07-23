require 'rails_helper'

feature 'reviewing' do

  context 'creating reviews' do
    before { Restaurant.create name: 'KFC' }

    scenario 'allows users to leave a review using a form' do
      visit '/restaurants'
      sign_up
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'Mumtaaaz'
      select '3', from: 'Rating'
      click_button 'Leave Review'

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content ('Mumtaaaz')
    end
  end

  context 'tying in reviews/restaurant deletion' do
    before(:each) do
      restaurant = Restaurant.create name: 'KFC'
      Review.create(thoughts: 'great', rating: 4, restaurant_id: restaurant.id)
    end

    scenario 'reviews are deleted when restaurant is deleted' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'great'
    end
  end

  def sign_up
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

end
