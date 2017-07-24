class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :authentication_token, :email, :username, :fullname, :avatar_url

  def authentication_token
    JsonWebToken.encode({ user_id: object.id })
  end

  # def attrs
  #   {
      
  #   }
  # end

end