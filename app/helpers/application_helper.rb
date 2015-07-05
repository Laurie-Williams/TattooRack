module ApplicationHelper

  def piece_index_offset(iterator)
    if params[:page]
      (params[:page].to_i - 1) * 12 + iterator
    else
      iterator
    end
  end

end
