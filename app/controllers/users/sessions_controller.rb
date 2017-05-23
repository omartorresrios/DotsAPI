class Users::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user = User.authenticate(email_or_fullname, params[:password])
      render json: user, serializer: CurrentUserSerializer, status: 200
    else
      render json: { errors: ['Invalid email and password'] }, status: 422
    end
  end

  private

    def email_or_fullname
      params[:email] || params[:fullname]
    end
end