class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def events
    events = @user.events
    render json: events, status: 200
  end

  def reviews
    @reviews = @user.received_reviews.recent
    render json: @reviews, status: 200
  end

  private

    def set_user
      @user = User.find(current_user)
    end

end