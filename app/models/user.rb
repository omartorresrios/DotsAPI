class User < ActiveRecord::Base
  before_save :encrypt_password
  has_secure_password validations: false

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  FULLNAME_REGEX = /\A[a-zA-Z0-9_-]{3,30}\z/

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }, unless: :facebook_login?
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :fullname, presence: true, format: { with: FULLNAME_REGEX, message: "should be one word" }, unless: :facebook_login?
  validates :password, presence: true, length: { minimum: 8 }, unless: :facebook_login?

  mount_uploader :avatar, AvatarUploader

  def encrypt_password
    if password.present?      
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def self.authenticate(login_name, password)
    user = self.where("email =?", login_name).first
                   
    if user 
      puts "******************* #{password} 1"
      
      begin
        password = AESCrypt.decrypt(password, ENV["API_AUTH_PASSWORD"])      
      rescue Exception => e
        password = nil
        puts "error - #{e.message}"
      end
      
      puts "******************* #{password} 2"
              
      if user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    else
      nil
    end
  end

  # def self.authenticate(email_or_fullname, password)
  #   user = User.find_by(email: email_or_fullname) || User.find_by(username: email_or_fullname)
  #   user && user.authenticate(password)
  # end

  def facebook_login?
    facebook_id.present?
  end

  def avatar_url
    if facebook_login? && avatar.url.nil?
      "https://graph.facebook.com/#{facebook_id}/picture?type=large"
    else
      avatar.url    
    end
  end
end
