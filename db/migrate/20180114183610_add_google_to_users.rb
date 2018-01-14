class AddGoogleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_id, :integer, limit: 8
    add_index :users, :google_id
  end
end
