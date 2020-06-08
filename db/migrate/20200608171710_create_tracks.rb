class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.boolean :finished
      t.integer :number_of_racers
      t.text :description
      t.integer :level
      t.date :date
      t.float :distance
      t.float :latitude
      t.float :longitude
      t.datetime :time_to_complete

      t.timestamps
    end
  end
end
