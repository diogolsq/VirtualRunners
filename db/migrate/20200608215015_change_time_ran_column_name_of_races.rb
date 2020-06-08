class ChangeTimeRanColumnNameOfRaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :races, :time_ran, :time_start
  end
end
