class PiecesController < ApplicationController
  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    if @piece.save
      redirect_to piece_path @piece
    else
      flash.now[:alert] = "your piece has failed to be created"
      render new_piece_path
    end
  end

  def show
    @piece = Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:image)
  end
end
