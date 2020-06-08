class RemoveFinishedOfTracksAddFinishedtoTracks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tracks, :finished
    add_column :tracks, :finished, :boolean , :default => false



  end
end
