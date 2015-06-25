class AddCachedVotesUpToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :cached_votes_up, :integer, :default => 0
    add_index  :pieces, :cached_votes_up
  end
end
