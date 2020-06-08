class RemoveLatitudeLongitudeOfTrack < ActiveRecord::Migration[6.0]
  def change
    remove_column :tracks, :latitude
    remove_column :tracks, :longitude
  end
end
