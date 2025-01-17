class ApplicationController < ActionController::API
  before_action :authorized

  JWT_SECRET = Rails.application.credentials.JWT_SECRET

  def encoded_token(payload)
    JWT.encode(payload,JWT_SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, JWT_SECRET)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end
  
  def authorized
    render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
  end
end
