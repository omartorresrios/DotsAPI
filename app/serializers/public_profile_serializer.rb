class PublicProfileSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :attrs, :username, :fullname, :avatar_url
end