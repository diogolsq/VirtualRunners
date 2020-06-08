class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
      t.references :user, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.float :km_ran
      t.datetime :time_ran

      t.timestamps
    end
  end
end
