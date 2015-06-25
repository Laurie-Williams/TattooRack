class VotesController < ApplicationController
  before_action :authenticate_user
  before_action :assign_votable

  def like
    @votable.liked_by(current_user)
    if request.xhr?
      render partial: "likes", locals: { votable: @votable }
    else
      redirect_to :back
    end
  end

  def unlike
    @votable.unliked_by(current_user)
    if request.xhr?
      render partial: "likes", locals: { votable: @votable }
    else
      redirect_to :back
    end
  end

  private

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  def assign_votable
    @votable_class = request.path.split("/")[1].singularize.capitalize.constantize
    @votable_id = request.path.split("/")[2]
    @votable = @votable_class.find(@votable_id)
  end

end
