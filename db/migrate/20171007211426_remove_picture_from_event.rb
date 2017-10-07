class RemovePictureFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :picture, :string
  end
end
