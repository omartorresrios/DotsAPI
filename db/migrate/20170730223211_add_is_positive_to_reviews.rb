class AddIsPositiveToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :isPositive, :boolean
  end
end
