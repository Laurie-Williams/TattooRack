class SearchController < ApplicationController

  def search
    if params[:q].present?
      @pieces = PiecesIndex.search(params[:q]).load
      @users = UsersIndex.search(params[:q]).load
    else
      redirect_to root_path
    end

  end

end
