class RemoveContentFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :content, :string
  end
end
