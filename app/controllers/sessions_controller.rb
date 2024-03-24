class SessionsController < ApplicationController
  def create
    player = Player.find_by(user_name: params[:user_name])

    if player&.authenticate(params[:password])
      token = jwt_encode({ player_id: player.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
