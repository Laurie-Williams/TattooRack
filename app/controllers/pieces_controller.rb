class PiecesController < ApplicationController

  before_action :find_piece, only: [:show, :edit, :update, :destroy]

  def show
    unless @piece.published?
      flash[:alert] = "Piece could not be found"
      redirect_to new_piece_path
    end
  end

  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
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
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @piece.update_attributes(piece_params)
      flash[:notice] = "Your piece has been updated"
      redirect_to edit_piece_path @piece
    else
      flash.now[:alert] = "Your piece was not updated"
      render :edit
    end
  end

  def destroy
    if @piece.destroy
      flash[:notice] = "Your piece has been deleted"
      redirect_to new_piece_path
    else
      flash.now[:alert] = "Your piece was not deleted"
      render :edit
    end
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
  # if @piece does not exist redirect to home with error
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Piece could not be found"
    redirect_to root_path
  end

  def piece_params
    params.require(:piece).permit(:image, :title, :description, :published)
  end
end
