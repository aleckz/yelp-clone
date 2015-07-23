require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context 'setting limits on users' do
    before { Restaurant.create name: 'KFC' }
    scenario 'user cannot create a restaurant unless they are logged in' do
      visit('/')
      click_link('Add a restaurant')
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_content("Log in")
    end

    scenario 'user can only edit restaurants they create' do
      visit ('/')
      sign_up
      click_link('Edit KFC')
      expect(page).to have_content "You can't edit someone else's restaurant"
    end

    scenario 'user can only delete restaurants they create' do
      visit ('/')
      sign_up
      click_link('Delete KFC')
      expect(page).to have_content "You can't delete someone else's restaurant"
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
end
