class PostsController < ApplicationController
  def index
    @posts = Post.where(params[:author_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(params[:comment_post_id])
  end
end
