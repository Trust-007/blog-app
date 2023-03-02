class PostsController < ApplicationController
  def index
    @posts = Post.where(params[:author_id])
    @user = User.find(params[:user_id])
    @comments = @posts.each { |post| post.five_most_recent_comments}
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(params[:comment_post_id])
  end
end
