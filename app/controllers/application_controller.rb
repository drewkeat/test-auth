class ApplicationController < ActionController::API
  JWT_SECRET = Rails.application.credentials.JWT_SECRET

  def encoded_token(payload)
    JWT.encode(payload,JWT_SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token(token)
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, JWT_SECRET)
      rescue => JWT::DecodeError
        nil
      end
    end
  end

end
