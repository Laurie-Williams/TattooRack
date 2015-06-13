class PiecesController < ApplicationController
  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    if @piece.save
      redirect_to pieces_path @piece
    else
      flash[:alert] = "your piece has failed to be created"
      render new_piece_path
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:image)
  end
end
