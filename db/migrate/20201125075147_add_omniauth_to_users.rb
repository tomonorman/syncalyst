class AddOmniauthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
