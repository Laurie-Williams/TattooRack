class AddDefaultValueToViewsCount < ActiveRecord::Migration
  def up
    change_column :pieces, :views_count, :integer, default: 0
  end

  def down
    change_column :pieces, :views_count, :integer, default: nil
  end
end
