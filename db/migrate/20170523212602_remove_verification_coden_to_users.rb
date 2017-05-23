class RemoveVerificationCodenToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :verification_code, :string
  end
end
