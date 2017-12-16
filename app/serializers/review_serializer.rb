class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :audio, :duration, :review_url, :created_at, :from, :to

  belongs_to :sender, :class_name => 'User', :foreign_key => 'from', serializer: UserSerializer
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to', serializer: UserSerializer

  def review_url
    object.audio.url
  end

end