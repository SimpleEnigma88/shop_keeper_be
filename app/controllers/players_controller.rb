class PlayersController < ApplicationController
  def index
      players = Player.all
      render json: players
  end

  def show
      player = Player.find(params[:id])
      
      if player 
          render json: player
      else
          render json: player.errors, status: :unprocessable_entity
      end
  end

  def create
      player = Player.create(player_params)
      
      if player.save
          render json: player, status: :created
      else
          render json: player.errors, status: :unprocessable_entity
      end
  end

  def update
    player = Player.find(params[:id])

    if player.update(player_params)
      render json: player
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

def destroy
  player = Player.find(params[:id])

  # Create a copy of each character associated with the player that is in a party
  player.characters.where.not(party_id: nil).each do |character|
    copied_character = character.dup
    copied_character.save!

    # Copy each magic item associated with the character
    character.magic_items.each do |magic_item|
      copied_magic_item = magic_item.dup
      copied_magic_item.character_id = copied_character.id
      copied_magic_item.save!
    end
  end

  if player.destroy
    render json: player
  else
    render json: player.errors, status: :unprocessable_entity
  end
end

  private
  
  def player_params
      params.require(:player).permit(:user_name, :email, :first_name, :last_name)
  end
end
