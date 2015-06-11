class UsersController < ApplicationController

  before_action :find_user, only: [:edit, :update]
  before_action :authorize_user, except: [:index]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "You have updated your settings"
      redirect_to edit_user_path @user.id
    else
      flash.now[:alert] = "Your settings have failed to update"
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :bio)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def authorize_user
    if current_user == @user
      # continue
    else
      # Prompt for Sign In
      redirect_to new_user_session_path
      flash[:alert] = "You do not have permission to view this page"
    end
  end
end
