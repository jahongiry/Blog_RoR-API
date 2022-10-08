require 'rails_helper'
RSpec.describe 'users#index', type: :feature do
  describe 'user index page' do
    before(:each) do
      @user1 = User.create(name: 'Rito', email: 'rito@gmail.com',
                           password: 'password', photo: 'Tom.png', bio: 'bio', posts_counter: 0)
      @user2 = User.create(name: 'Amy', email: 'amy@gmail.com',
                           password: 'password', bio: 'bio', photo: 'Tom.png')
      @user3 = User.create(name: 'Jerry', email: 'jerry@gmail.com',
                           password: 'password', bio: 'bio', photo: 'Tom.png')

      visit root_path
      fill_in 'Email', with: 'rito@gmail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end

    it "Shows the user's photo" do
      all('img').each do |i|
        expect(i[:src]).to eq('Tom.png')
      end
    end

    it 'shows the number of posts each user has written' do
      expect(page).to have_content('0')
    end
  end
end
