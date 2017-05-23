class RemoveEmailVerificationToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email_verification, :boolean
  end
end
