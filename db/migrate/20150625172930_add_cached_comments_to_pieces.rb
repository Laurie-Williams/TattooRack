class AddCachedCommentsToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :cached_comments, :integer
  end
end
