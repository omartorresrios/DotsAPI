class RemoveAuthTokenExpiryToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :authtoken_expiry, :datetime
  end
end
