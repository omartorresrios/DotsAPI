class ProfileController < ApplicationController
  before_action :set_user
  before_filter :authenticate_user!, only: [:follow, :unfollow]

  def ask
    Review.create_review(@user, current_user, review_params)
    redirect_to profile_reviews_path params[:username]
  end

  def review
    @reviews = @user.received_reviews
  end

  private
    def review_params
      unless user_signed_in?
        params[:content]['anonymous'] = 1
      end
      params.require(:review).permit(:content, :anonymous)
    end

    def set_user
      @user = User.find_by_username params[:username]

      if @user.nil?
        redirect_to root_path
      end
    end
end