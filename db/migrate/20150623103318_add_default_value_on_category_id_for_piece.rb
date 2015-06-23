class AddDefaultValueOnCategoryIdForPiece < ActiveRecord::Migration
  def change
    change_column :pieces, :category_id, :integer, :default => 1
  end
end
