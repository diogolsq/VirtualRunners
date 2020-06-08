class AddStartAdressEndAdressStartLatitudeStartLongitudeEndLatitudeEndLongitudeToTracks < ActiveRecord::Migration[6.0]
  def change

    add_column :tracks, :start_address, :string
    add_column :tracks, :end_address, :string
    add_column :tracks, :start_latitude, :float
    add_column :tracks, :start_longitude, :float
    add_column :tracks, :end_latitude, :float
    add_column :tracks, :end_longitude, :float

  end
end
