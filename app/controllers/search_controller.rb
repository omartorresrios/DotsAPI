class SearchController < ApplicationController
  # before_action :authenticate_user!

  def index
  	@users = User.all
  	render json: @users, status: 200
  end

  def search
    @users = []
  end

  def do_search
    @users = User.search params[:query], current_user.id
    render 'search/search'
  end

end