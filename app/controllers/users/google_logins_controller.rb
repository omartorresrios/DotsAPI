class Users::GoogleLoginsController < ApplicationController
  def create
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
      username = generate_unique_username
      params.permit(:google_id).merge(username: username)
    end

    def generate_unique_username
      name = params[:username].split.join('-')
      loop do
        username = name + SecureRandom.random_number(10000..99999)
        break username unless User.exists?(username: username)
      end
	end
end