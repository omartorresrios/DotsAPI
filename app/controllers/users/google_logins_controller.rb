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
      fullname = generate_unique_fullname
      params.permit(:google_id).merge(fullname: fullname)
    end

    def generate_unique_username
      name = params[:fullname].split.join('-').downcase
      loop do
        fullname = "#{name}#{SecureRandom.random_number(1000..9999).to_s}"
        break fullname unless User.exists?(fullname: fullname)
      end
    end
end