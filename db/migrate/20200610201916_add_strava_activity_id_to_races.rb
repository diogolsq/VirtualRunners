class AddStravaActivityIdToRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :strava_activity_id, :string
  end
end
