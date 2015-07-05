class UsersController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  before_action :authorize_user, except: [:index, :show]

  def index
    @users = User.all.page(params[:page]).per(12)
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

  def show

  end

  def destroy
    if @user.destroy
      flash[:notice] = "The user was deleted"
      redirect_to users_path
    else
      flash[:alert] = "The user was not deleted"
      redirect_to user_path @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :bio, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  def authorize_user
    if current_user.admin? || current_user == @user
      # continue
    else
      # Prompt for Sign In
      redirect_to users_path
      flash[:alert] = "You do not have permission to view this page"
    end
  end

end
