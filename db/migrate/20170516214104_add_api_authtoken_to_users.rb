class AddApiAuthtokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_authtoken, :string
  end
end
