class CommentsController < ApplicationController
  before_action :assign_commentable, only: [:create, :destroy]
  before_action :assign_comment, only: [:destroy]
  before_action :authenticate_user
  before_action :authorize_user, except: [:create]

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

  def assign_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  def authorize_user
    if current_user == @comment.user
      # continue
    else
      # Prompt for Sign In
      redirect_to root_path
      flash[:alert] = "Oops this piece doesn't belong to you"
    end
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end

end
