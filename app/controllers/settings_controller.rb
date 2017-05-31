class SettingsController < ApplicationController
  # before_action :authenticate_user!

  def profile

  end

  def update_profile
    current_user.update_attributes profile_params
  end

  def avatar

  end

  # def update_avatar
  #   current_user.update params.require(:user).permit(:avatar)
  # end

  def update_avatar
    image = StringIO.new(Base64.decode64(params.require(:user).permit(:avatar).tr(' ', '+')))
    image.class.class_eval { attr_accessor :original_filename, :content_type }
    image.original_filename = SecureRandom.hex + '.png'
    image.content_type = 'image/png'

    current_user.update_attributes(image)
  end

  protected
  def profile_params
    params.require(:user).permit(:email, :fullname)
  end
end