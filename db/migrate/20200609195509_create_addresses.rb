class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :category
      t.references :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
