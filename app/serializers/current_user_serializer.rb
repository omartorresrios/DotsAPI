class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :fullname, :username, :created_at
end