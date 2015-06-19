class AddPositionToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :position, :integer
  end
end
