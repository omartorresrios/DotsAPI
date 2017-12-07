class Event < ActiveRecord::Base
  belongs_to :user
  # has_many :likes, dependent: :destroy
  # has_many :likers, through: :likes, source: :user
  # has_many :comments, dependent: :destroy
  # has_many :taggings, dependent: :destroy
  # has_many :tags, through: :taggings

  validates :user_id, presence: true
  validates :description, presence: true

  # has_attached_file :picture, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  # validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  has_attached_file :video, styles: {
        :medium => {
          :geometry => "640x480",
          :format => 'mp4'
        },
        :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10}
    }, :processors => [:transcoder]
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

  # mount_uploader :photo, PhotoUploader

  # scope :get_page, -> (page, per_page = 10) {
  #   includes(:user, :comments).order(created_at: :desc).paginate(page: page, per_page: per_page)
  # }

  # attr_accessor :picture_data
  attr_accessor :video_data

  # before_save :decode_picture_data
  before_save :decode_video_data

  # def decode_picture_data
  #   # If avatar_data is present, it means that we were sent an avatar over
  #   # JSON and it needs to be decoded.  After decoding, the avatar is processed
  #   # normally via Paperclip.
  #   if self.picture_data.present?
  #     data = StringIO.new(Base64.decode64(self.picture_data))
  #     data.class.class_eval {attr_accessor :original_filename, :content_type}
  #     data.original_filename = self.id.to_s + ".png"
  #     data.content_type = "image/png"

  #     self.picture = data
  #   end
  # end

  def decode_video_data
    # If avatar_data is present, it means that we were sent an avatar over
    # JSON and it needs to be decoded.  After decoding, the avatar is processed
    # normally via Paperclip.
    if self.video_data.present?
      data = StringIO.new(Base64.decode64(self.video_data))
      data.class.class_eval {attr_accessor :original_filename, :content_type}
      data.original_filename = self.id.to_s + ".mp4"
      data.content_type = "video/mp4"

      self.video = data
    end
  end

  def event_url
    # if self.picture_file_name.nil?
    video.url(:original)
    # else
    #   picture.url
    # end
  end

  def event_url_thumb
    video.url(:thumb)
  end

  def user_avatar_url
    user.avatar.url
  end

end
