class RemoveCachedCommentsFromPieces < ActiveRecord::Migration
  def change
    remove_column :pieces, :cached_comments
  end
end
