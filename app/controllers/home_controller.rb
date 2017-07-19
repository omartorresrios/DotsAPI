class HomeController < ApplicationController
  def home
    # if user_signed_in?
      redirect_to search_search_path
    # end
    # @users = User.get_random
  end
end