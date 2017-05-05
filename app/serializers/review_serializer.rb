class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :from

  belongs_to :sender, :class_name => 'User', :foreign_key => 'from', serializer: UserSimpleSerializer
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to', serializer: UserSimpleSerializer

end