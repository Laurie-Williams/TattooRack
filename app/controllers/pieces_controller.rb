class PiecesController < ApplicationController
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

  def show
    @piece = Piece.find(params[:id])
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:image)
  end
end
