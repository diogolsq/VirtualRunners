class AddNameToTrack < ActiveRecord::Migration[6.0]
  def change

  add_column :tracks, :name, :string

  end
end
