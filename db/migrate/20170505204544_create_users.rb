class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :username, unique: true
  end
end
