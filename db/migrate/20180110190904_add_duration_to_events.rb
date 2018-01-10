class AddDurationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :duration, :interval
  end
end
