class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  	@reviews = Review.all
  	render json: @reviews, status: 200
  end

  def home
    # if user_signed_in?
      redirect_to search_search_path
    # end
    # @users = User.get_random
  end
end