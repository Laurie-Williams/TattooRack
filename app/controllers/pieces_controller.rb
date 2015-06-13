class PiecesController < ApplicationController

  before_action :find_piece, only: [:show, :edit, :update]

  def show
  end

  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    @piece.check_and_set_title
    if @piece.save
      redirect_to edit_piece_path @piece
    else
      flash.now[:alert] = "your piece has failed to be created"
      render new_piece_path
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

  private

  def find_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:image, :title, :description)
  end
end
