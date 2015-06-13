class PiecesController < ApplicationController
  def new
    @piece = Piece.new
  end
end
