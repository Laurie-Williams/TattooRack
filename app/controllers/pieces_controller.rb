class PiecesController < ApplicationController
  before_action :authenticate_user, except:[:index, :show]
  before_action :find_piece, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:index, :new, :show, :create, :crop]

  # GET /pieces
  def index
    @pieces = Piece.all_by_created_at
  end

  # GET /pieces/:id
  def show
    unless @piece.published?
      flash[:alert] = "Piece could not be found"
      redirect_to new_piece_path
    end
  end

  # POST /pieces/new
  def new
    @piece = Piece.new
  end

  # POST /pieces/:id
  def create
    @piece = current_user.pieces.build(piece_params)
    @piece.check_and_set_title
    respond_to do |format|
      if @piece.save
        format.html {redirect_to edit_piece_path @piece}
        format.json {render json: @piece, status: :created}
      else
        format.html do
          flash.now[:alert] = "your piece has failed to be created"
          render new_piece_path
        end
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /pieces/:id/edit
  def edit
  end

  # PUT /pieces/:id
  def update
    if @piece.update_attributes(piece_params)
      flash[:notice] = "Your piece has been updated"
      redirect_to piece_path @piece
    else
      flash.now[:alert] = "Your piece was not updated"
      render :edit
    end
  end

  # DELETE /peices/:id
  def destroy
    if @piece.destroy
      flash[:notice] = "Your piece has been deleted"
      redirect_to pieces_path
    else
      flash.now[:alert] = "Your piece was not deleted"
      render :edit
    end
  end

  # GET /pieces/crop
  def crop
    render partial: "crop"
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
  # if @piece does not exist redirect to home with error
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Piece could not be found"
    redirect_to root_path
  end

  def authorize_user
    if current_user.admin? || (current_user == @piece.user)
      # continue
    else
      # Prompt for Sign In
      redirect_to root_path
      flash[:alert] = "Oops this piece doesn't belong to you"
    end
  end

  def authenticate_user
    if current_user.nil?
      flash[:alert] = "You need to sign in to view this"
      redirect_to new_user_session_path
    end
  end

  # must have attr_accessor params declared before :image param to be visible in the uploader
  def piece_params
    params.require(:piece).permit(:crop_x, :crop_y, :crop_height, :crop_width, :image, :title, :description, :published)
  end
end
