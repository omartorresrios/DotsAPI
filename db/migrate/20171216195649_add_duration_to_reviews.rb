class AddDurationToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :duration, :interval
  end
end
