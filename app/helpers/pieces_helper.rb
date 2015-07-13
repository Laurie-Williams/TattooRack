module PiecesHelper

  def piece_list_link
    if @piece.list
      @piece.list.capitalize
      link_to @piece.list.capitalize.pluralize, pieces_path(list: @piece.list)
    else
      link_to "Pieces", pieces_path
    end
  end
end
