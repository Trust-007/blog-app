class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      user = User.find(params[:user_id])
      redirect_to user_posts_path(user)
    else
      render :new
    end
  end

   def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to root_path, notice: 'Comment was successfully deleted.'
  end
  
  private

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: Post.find(params[:post_id]))
  end
end
