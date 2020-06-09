class DropAdresses < ActiveRecord::Migration[6.0]
  def change
    drop_table :addresses
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end

end
