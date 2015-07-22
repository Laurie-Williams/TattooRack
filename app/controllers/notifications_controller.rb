class NotificationsController < ApplicationController
  before_action :assign_activity, only:[:viewed]
  before_action :authenticate_user
  before_action :authorize_user, except: [:index, :count]

  def index
    @activities = PublicActivity::Activity.all.order("created_at desc").where(recipient_id: current_user).where.not(owner_id: current_user).limit(10)
    render partial: "notifications/notifications"
  end

  def count
    @count = PublicActivity::Activity.where(recipient_id: current_user, viewed: false).where.not(owner_id: current_user).count
    render json: @count
  end

  def viewed
    if @activity.update_attributes(viewed: true)
      head :ok
    end
  end

  private

  def assign_activity
    @activity = PublicActivity::Activity.find(params[:id])
  end

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  def authorize_user
    if current_user == @activity.recipient
      # continue
    else
      # Prompt for Sign In
      redirect_to root_path
      flash[:alert] = "Oops this piece doesn't belong to you"
    end
  end

end
