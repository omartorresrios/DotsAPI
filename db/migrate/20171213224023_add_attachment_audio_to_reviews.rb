class AddAttachmentAudioToReviews < ActiveRecord::Migration
  def self.up
    change_table :reviews do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :reviews, :audio
  end
end
