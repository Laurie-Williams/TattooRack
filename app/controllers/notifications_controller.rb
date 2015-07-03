class NotificationsController < ApplicationController

  def index
    @activities = PublicActivity::Activity.all.order("created_at desc").where(recipient_id: current_user).where.not(owner_id: current_user)
    render partial: "notifications/notifications"
  end

  def count
    @count = PublicActivity::Activity.where(recipient_id: current_user, viewed: false).where.not(owner_id: current_user).count
    render json: @count
  end

  def viewed
    @activity = PublicActivity::Activity.find(params[:id])
    if @activity.update_attributes(viewed: true)
      head :ok
    end

  end

end
