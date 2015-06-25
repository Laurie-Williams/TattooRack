class AddDefaultValueToCommentsCount < ActiveRecord::Migration
  def up
    change_column :pieces, :comments_count, :integer, default: 0
  end

  def down
    change_column :pieces, :comments_count, :integer, default: nil
  end
end
