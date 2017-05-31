class SettingsController < ApplicationController
  before_action :authenticate_user!

  def profile

  end

  def update_profile
    current_user.update_attributes profile_params
  end

  def avatar

  end

  def update_avatar
    current_user.update params.require(:user).permit(:avatar)
  end

  protected
  def profile_params
    params.require(:user).permit(:email, :fullname)
  end
end