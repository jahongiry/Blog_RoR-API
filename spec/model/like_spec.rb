require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do
    it { should belong_to(:author) }
    it { should belong_to(:post) }
  end
  describe 'Tests for Like model' do
    user = User.create(name: 'Tom', email: 'admin1@email.com', password: 'passowrd',
                       photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    subject { Like.new }
    before { subject.save }

    it '#update_post_likes_counter' do
      post.likes_counter = 2
      subject.post = post
      expect(subject.post.likes_counter).to eq 2
    end
  end
end
