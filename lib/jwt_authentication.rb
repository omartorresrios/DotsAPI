module JwtAuthentication
 require 'json_web_token'

 # JWT's are stored in the X-Auth-Token header using this format:
 def claims
   token = request.headers['X-Auth-Token']&.split(' ')&.last
   JsonWebToken.decode(token) if token
 end

 def invalid_authentication
   render json: { error: t('devise.failure.unauthenticated') }, status: :unauthorized
 end
end