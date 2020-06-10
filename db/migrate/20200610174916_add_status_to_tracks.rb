class AddStatusToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :status, :string, default: "open"
  end
end
