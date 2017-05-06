class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX }, unless: :facebook_login?
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :fullname, presence: true, length: { in: 2..30 }
  validates :password, length: { minimum: 8 }, unless: :facebook_login?

  mount_uploader :avatar, AvatarUploader

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end

  def facebook_login?
    facebook_id.present?
  end

  def avatar_url
    if facebook_login? && avatar.url.nil?
      "http://graph.facebook.com/#{facebook_id}/picture?type=large"
    else
      avatar.url    
    end
  end
end
