class AddCommentsCountToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :comments_count, :integer
  end
end
