class AddAuthTokenExpiryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authtoken_expiry, :datetime
  end
end
