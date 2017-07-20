class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :authentication_token, :attrs

  def authentication_token
    JsonWebToken.encode({ user_id: object.id })
  end

  def attrs
    {
      email: object.email,
      username: object.username,
      fullname: object.fullname,
      # avatar_url: object.avatar.url
    }
  end

end