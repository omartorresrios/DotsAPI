class UserSimpleSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :avatar_url

  def avatar_url
    object.avatar_url
  end
end