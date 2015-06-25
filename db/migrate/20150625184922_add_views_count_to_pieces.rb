class AddViewsCountToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :views_count, :integer
  end
end
