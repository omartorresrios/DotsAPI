class AddAttachmentVideoToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :events, :video
  end
end
