class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = JWT.decode(header, Rails.application.credentials.secret_key_base).first
      @current_user = Player.find(decoded['player_id'])
    rescue JWT::ExpiredSignature
      render json: { error: 'Expired token' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
