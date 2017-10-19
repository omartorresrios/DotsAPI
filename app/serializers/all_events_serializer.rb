class AllEventsSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :description, :likes_count, :picture_content_type, 
  			 :picture_file_name, :picture_file_size, :picture_updated_at,
  			 :updated_at, :user_id, :video_content_type, :video_file_name,
  			 :video_file_size, :video_updated_at, :event_url

  belongs_to :user, serializer: UserSerializer
end