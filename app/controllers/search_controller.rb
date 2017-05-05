class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = []
  end

  def do_search
    @users = User.search params[:query], current_user.id
    render 'search/search'
  end

end