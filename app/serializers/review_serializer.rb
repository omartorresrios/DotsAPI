class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :from, :to

  belongs_to :sender, :class_name => 'User', :foreign_key => 'from', serializer: UserSerializer
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to', serializer: UserSerializer

end