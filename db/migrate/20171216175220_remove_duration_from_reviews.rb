class RemoveDurationFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :duration, :string
  end
end
