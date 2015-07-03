class CommentsController < ApplicationController
  before_action :assign_commentable, only: [:create, :destroy]

  def create
    if @commentable.comments.create(comment_params)
      @comments = @commentable.comments
      if request.xhr?
        render partial: :comment, collection: @comments,
               locals: {commentable: @commentable}
      else
        redirect_to :back, notice: "Your comment was created"
      end
    else
      redirect_to :back, alert: "Your comment was not created"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      @comments = @commentable.comments
      if request.xhr?
        render partial: :comment, collection: @comments,
             locals: {commentable: @commentable}
      else
        redirect_to :back, notice: "Your comment was deleted"
      end

    else
      redirect_to :back, alert: "Your comment was not deleted"
    end
  end

  private

  def assign_commentable
    @commentable_type = request.path.split("/")[1].singularize.capitalize
    @commentable_id = request.path.split("/")[2]
    @commentable = Comment.find_commentable(@commentable_type, @commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end

end
