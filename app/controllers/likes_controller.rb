class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    like = current_user.likes.new(
      author_id: current_user.id,
      post_id: @post.id
    )

    if like.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your like has been saved' }
    else
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash.now[:error] = 'Can not save your like'
    end
  end
end
