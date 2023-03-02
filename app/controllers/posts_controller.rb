class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(params[:comment_post_id])
  end
end
