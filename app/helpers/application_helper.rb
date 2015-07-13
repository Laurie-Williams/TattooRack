module ApplicationHelper

  def piece_index_offset(iterator)
    if params[:page]
      (params[:page].to_i - 1) * 15 + iterator
    else
      iterator
    end
  end

end
