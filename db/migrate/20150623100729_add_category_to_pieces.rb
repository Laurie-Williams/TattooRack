class AddCategoryToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :category_id, :integer
  end
end
