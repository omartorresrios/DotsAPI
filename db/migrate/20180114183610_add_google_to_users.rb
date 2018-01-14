class AddGoogleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_id, :integer
    add_index :users, :google_id
  end
end
