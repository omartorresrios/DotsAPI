class ProfileController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def show
    if @user.present?
      render json: @user, serializer: PublicProfileSerializer, status: 200
    else
      render json: { errors: ["User not found"] }, status: 422
    end
  end

  def reviews
    if @user.present?
      render :json => @user.received_reviews.recent, status: 200
    else
      render json: { errors: ["User not found"] }, status: 422
    end
  end

  def events
    if @user.present?
      events = @user.events
      render :json => events.to_json(:methods => [:event_url, :user_avatar_url, :user_fullname]), status: 200
    else
      render json: { errors: ["User not found"] }, status: 422
    end
  end

  def speak
    review = Review.create_review(@user, current_user, review_params)
    # redirect_to profile_reviews_path params[:username]
    if review.save
      render json: review, status: 201
    else
      render json: { errors: review.errors.full_messages }, status: 422
    end
  end

  private
    def review_params
      params.permit(:audio, :duration)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end