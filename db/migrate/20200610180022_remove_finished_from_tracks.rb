class RemoveFinishedFromTracks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tracks, :finished
  end
end
