class AddPublishedToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :published, :boolean, default: false
  end
end
