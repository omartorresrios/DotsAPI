class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :from
      t.string :to
      t.string :content

      t.timestamps null: false
    end
  end
end
