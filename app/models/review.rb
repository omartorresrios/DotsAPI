class Review < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'from'
  belongs_to :receiver, class_name: 'User', foreign_key: 'to'

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def self.mine(user_id, review_id)
    where(to: user_id).where(id: review_id).first
  end

  def self.create_review(user, current, params)
    review = Review.new
    review.from = current.nil? ? nil : current.id
    review.to = user.id
    review.content = params[:content]
    # review.anonymous = params[:anonymous].to_i == 1 ? true : false
    review.isPositive = params[:isPositive]
    review.created_at = Time.now
    review.save
    review
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