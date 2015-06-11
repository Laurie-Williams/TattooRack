class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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


end
