class RemoveApiAuthtokenToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :api_authtoken, :string
  end
end
