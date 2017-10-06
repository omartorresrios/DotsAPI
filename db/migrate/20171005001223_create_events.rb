class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :likes_count
      t.string :picture
      t.string :description

      t.timestamps null: false
    end
  end
end
