class AddColumnsToRace < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :distance, :float
    add_column :races, :elapsed_time, :integer
    add_column :races, :start_lat_lng, :string, array: true, default: []
    add_column :races, :end_lat_lng, :string, array: true, default: []
    add_column :races, :average_speed, :float
    add_column :races, :max_speed, :float
  end
end
