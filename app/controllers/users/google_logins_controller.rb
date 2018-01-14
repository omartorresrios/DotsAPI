class Users::GoogleLoginsController < ApplicationController
  def create
    @user = User.find_by(google_id: params[:google_id]) if params[:google_id].present?
    if @user
      render json: @user, serializer: CurrentUserSerializer, status: 200
    else
      @user = User.create!(user_params)
      render json: @user, serializer: CurrentUserSerializer, status: 201
    end
  end

  private

    def user_params
      username = generate_unique_username
      params.permit(:google_id).merge(username: username)
    end

    def generate_unique_username
      name = User.find_by(username: params[:username]).split.join('-').downcase
      loop do
        username = "#{name}#{SecureRandom.random_number(1000..9999).to_s}"
        break username unless User.exists?(username: username)
      end
    end
end