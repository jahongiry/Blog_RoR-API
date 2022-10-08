require 'rails_helper'
RSpec.describe 'posts#index', type: :feature do
  describe 'Post spec' do
    before(:each) do
      @user = User.create(name: 'Rito', email: 'rito@gmail.com', password: 'password',
                          photo: 'Tom.png', bio: 'bio', posts_counter: 0)

      visit root_path
      fill_in 'Email', with: 'rito@gmail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'

      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comments_conter: 0, likes_counter: 0,
                           author: @user)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comments_conter: 0, likes_counter: 0,
                           author: @user)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comments_conter: 0, likes_counter: 0,
                           author: @user)

      @comment1 = Comment.create(text: 'Good job!', author: User.first,
                                 post: Post.first)
      @comment2 = Comment.create(text: 'Keep it up!', author: User.first, post: Post.first)
      @comment3 = Comment.create(text: 'Congratulations!', author: User.first, post: Post.first)

      visit(user_posts_path(@user.id))
    end

    it "shows user's profile picture" do
      all('img').each do |i|
        expect(i[:src]).to eq('Tom.png')
      end
    end

    it 'shows the users username' do
      expect(page).to have_content('Rito')
    end

    it 'shows number of posts of user has written' do
      post = Post.all
      expect(post.size).to eql(3)
    end

    it 'shows number of posts by user' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'shows posts title' do
      expect(page).to have_content('First Post')
    end

    it 'can see some of the post detail' do
      expect(page).to have_content 'This is my first post'
    end

    it 'can see the first comment on a post' do
      expect(page).to have_content 'Good job!'
    end

    it 'can see how many comments a post has.' do
      post = Post.first
      expect(page).to have_content(post.comments_conter)
    end

    it 'can see how many likes a post has.' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it "redirects the user to the post's show page after clickin on it" do
      click_link 'First Post'
      expect(page).to have_current_path user_post_path(@post1.author_id, @post1)
    end
  end
end
