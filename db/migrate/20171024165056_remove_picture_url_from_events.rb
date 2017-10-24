class RemovePictureUrlFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :picture_url, :string
  end
end
