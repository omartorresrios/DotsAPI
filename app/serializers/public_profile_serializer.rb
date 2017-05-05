class PublicProfileSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :attrs

  def attrs
    {
      username: object.username,
      fullname: object.fullname,
      avatar_url: object.avatar.url
    }
  end
end