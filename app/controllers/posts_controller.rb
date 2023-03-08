class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(person_params)
    if @post.save
      redirect_to user_posts_path
    else
      render 'new'
    end
  end

  private

  def person_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user, comments_counter: 0, likes_counter: 0)
  end
end
