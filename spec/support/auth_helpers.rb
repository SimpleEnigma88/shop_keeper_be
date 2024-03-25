module AuthHelpers
  def auth_token_for_player(player)
    JWT.encode({ player_id: player.id }, Rails.application.credentials.secret_key_base)
  end
end
