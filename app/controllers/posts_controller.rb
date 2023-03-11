class PostsController < ApplicationController
   before_action :authenticate_user!, only: [:create]

  def index
    @user = User.includes(:posts).find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user.posts }
    end
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

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy!
    redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
  end

  private

  def person_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user)
  end
end
