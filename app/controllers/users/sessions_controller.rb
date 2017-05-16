class Users::SessionsController < ApplicationController
  def create
    if request.post?
      if params && params[:email] && params[:password]        
        user = User.where(:email => params[:email]).first
                      
        if user 
          if User.authenticate(params[:email], params[:password]) 
                    
            if !user.api_authtoken || (user.api_authtoken && user.authtoken_expiry < Time.now)
              auth_token = rand_string(20)
              auth_expiry = Time.now + (24*60*60)
          
              user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)    
            end 
                                   
            render json: user, serializer: CurrentUserSerializer, status: 200
            # render :json => user.to_json, :status => 200
          else
            render json: { errors: ['Invalid email and password'] }, status: 422
            # e = Error.new(:status => 401, :message => "Wrong Password")
            # render :json => e.to_json, :status => 401
          end      
        else
          e = Error.new(:status => 400, :message => "No USER found by this email ID")
          render :json => e.to_json, :status => 400
        end
      else
        e = Error.new(:status => 400, :message => "required parameters are missing")
        render :json => e.to_json, :status => 400
      end
    end

    # user = User.find_by(email: params[:email])
    # if user = User.authenticate(email_or_fullname, params[:password])
    #   render json: user, serializer: CurrentUserSerializer, status: 200
    # else
    #   render json: { errors: ['Invalid email and password'] }, status: 422
    # end
  end

  private

    def email_or_fullname
      params[:email] || params[:fullname]
    end
end