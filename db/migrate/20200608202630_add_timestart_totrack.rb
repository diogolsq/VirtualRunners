class AddTimestartTotrack < ActiveRecord::Migration[6.0]
  def change
  add_column :tracks, :time_to_start, :time

  change_column :tracks, :time_to_complete, :time

  end
end
