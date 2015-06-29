class TagsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :assign_taggable, except: [:show, :index]

  def index
    if request.xhr?
      @tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:term]}%").pluck(:name)
      render json: @tags
    end
  end

  def show
    @pieces = Piece.published.tagged_with(params[:tag])
    render "pieces/index"
  end

  def create
    @taggable.tag_list.add(params[:tag])
    @taggable.save
    render partial: "delete_tag_list", locals: { piece: @taggable }
  end

  def destroy
    @taggable.tag_list.remove(params[:id])
    @taggable.save
    render partial: "delete_tag_list", locals: { piece: @taggable }
  end

  private

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  def assign_taggable
    @taggable_class = request.path.split("/")[1].singularize.capitalize.constantize
    @taggable_id = request.path.split("/")[2]
    @taggable = @taggable_class.find(@taggable_id)
  end

end
