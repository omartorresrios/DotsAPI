class Review < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'from'
  belongs_to :receiver, class_name: 'User', foreign_key: 'to'

  validates :audio, presence: true

  has_attached_file :audio, :processors => [:transcoder]
  validates_attachment_content_type :audio, :content_type => /.*/

  scope :recent, -> { order(created_at: :desc) }

  attr_accessor :audio_data

  before_save :decode_audio_data

  def decode_audio_data
    if self.audio_data.present?
      data = StringIO.new(Base64.decode64(self.audio_data))
      data.class.class_eval {attr_accessor :original_filename, :content_type}
      data.original_filename = self.id.to_s + ".m4a"
      data.content_type = "audio/m4a"

      self.audio = data
    end
  end

  def self.mine(user_id, review_id)
    where(to: user_id).where(id: review_id).first
  end

  def self.create_review(user, current, params)
    review = Review.new
    review.from = current.nil? ? nil : current.id
    review.to = user.id
    review.audio = params[:audio]
    # review.anonymous = params[:anonymous].to_i == 1 ? true : false
    review.isPositive = params[:isPositive]
    review.created_at = Time.now
    review.save
    review
  end

  def review_url
    audio.url
  end

  def self.answer(user_id, review_id, params)
    params[:replied_at] = Time.now

    review = self.mine user_id, review_id

    if review
      review.update!(params)
      Activity.log(user_id, question_id)
      Notification.reply(review)
    end

    review
  end
end