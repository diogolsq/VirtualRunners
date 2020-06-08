class AddLevelUsernameNameRacesNumberBioToUser < ActiveRecord::Migration[6.0]
  def change

    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :races_number, :integer
    add_column :users, :Bio, :text
    add_column :users, :level, :integer

  end
end
