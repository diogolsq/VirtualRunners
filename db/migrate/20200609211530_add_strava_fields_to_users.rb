class AddStravaFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_img_url, :string
    add_column :users, :refresh_token, :string
  end
end
