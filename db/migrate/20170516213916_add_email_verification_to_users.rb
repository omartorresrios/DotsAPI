class AddEmailVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_verification, :boolean, :default => false
  end
end
