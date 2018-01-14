class Users::GoogleLoginsController < ApplicationController
  def create
    # TODO: find by either facebook_id OR email
    @user = User.find_by(google_id: params[:google_id]) if params[:google_id].present?
    if @user
      render json: @user, serializer: CurrentUserSerializer, status: 200
    # else
    #   # TODO: create unique username
      # @user = User.create!(user_params)
      # render json: @user, serializer: CurrentUserSerializer, status: 201
    end
  end

  private

    def user_params
      # TODO: generate random password
      params.permit(:google_id, :username).merge(password: 'password')
    end
end