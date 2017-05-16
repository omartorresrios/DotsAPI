class Users::RegistrationsController < ApplicationController
  # POST '/api/users/signup'
  # BODY: {
  #   email: String,
  #   fullname: String,
  #   username: String,
  #   password: String
  # }
  def create
    if request.post?
      if params && params[:full_name] && params[:email] && params[:password]
        
        params[:user] = Hash.new    
        params[:user][:first_name] = params[:full_name].split(" ").first
        params[:user][:last_name] = params[:full_name].split(" ").last
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
end