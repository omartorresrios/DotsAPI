class Users::RegistrationsController < ApplicationController
  before_filter :check_for_valid_authtoken, :except => [:signup, :signin, :get_token]

  # POST '/api/users/signup'
  # BODY: {
  #   email: String,
  #   fullname: String,
  #   username: String,
  #   password: String
  # }

  def create
    if request.post?
      if params && params[:fullname] && params[:username] && params[:email] && params[:password]
        
        params[:user] = Hash.new    
        params[:user][:fullname] = params[:fullname]
        params[:user][:username] = params[:username]
        params[:user][:email] = params[:email]
        
        begin 
          decrypted_pass = AESCrypt.decrypt(params[:password], ENV["API_AUTH_PASSWORD"])
        rescue Exception => e
          decrypted_pass = nil          
        end
                
        params[:user][:password] = decrypted_pass  
        params[:user][:verification_code] = rand_string(20)
        
        user = User.new(user_params)

        if user.save
          render json: user, serializer: CurrentUserSerializer, status: 201
          # render :json => user.to_json, :status => 200
        else
          render json: { errors: user.errors.full_messages }, status: 422
          # error_str = ""

          # user.errors.each{|attr, msg|           
          #   error_str += "#{attr} - #{msg},"
          # }
                    
          # e = Error.new(:status => 400, :message => error_str)
          # render :json => e.to_json, :status => 400
        end
      else
        e = Error.new(:status => 400, :message => "required parameters are missing")
        render :json => e.to_json, :status => 400
      end
    end

    # user = User.new(user_params)
    # if user.save
    #   render json: user, serializer: CurrentUserSerializer, status: 201
    # else
    #   render json: { errors: user.errors.full_messages }, status: 422
    # end
  end

  private

    def user_params
      params.permit(:username, :fullname, :email, :password)
    end

    def check_for_valid_authtoken
      authenticate_or_request_with_http_token do |token, options|     
        @user = User.where(:api_authtoken => token).first      
      end
    end

    def rand_string(len)
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      string  =  (0..len).map{ o[rand(o.length)]  }.join

      return string
    end

    def user_params
      params.require(:user).permit(:fullname, :username, :email, :password, :password_hash, :password_salt, :verification_code, 
      :email_verification, :api_authtoken, :authtoken_expiry)
    end
end