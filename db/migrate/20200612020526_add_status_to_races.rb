class AddStatusToRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :status, :string, default: "open"
  end
end
