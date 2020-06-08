class ChangeTimeRanTypeinRaces < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :time_ran, :time
  end
end
