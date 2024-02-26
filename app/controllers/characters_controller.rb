class CharactersController < ApplicationController
  def index
    player = Player.find(params[:player_id])
    characters = player.characters
    render json: characters
  end

  def create
    player = Player.find(params[:player_id])
    character = player.characters.new(character_params)

    if character.save
      render json: character, status: :created
    else
      render json: character.errors, status: :unprocessable_entity
    end
  end

  def update
    player = Player.find(params[:player_id])
    character = player.characters.find(params[:id])

    if character.update(character_params)
        render json: character
    else
        render json: character.errors, status: :unprocessable_entity
    end
    end

  private

  def character_params
    params.require(:character).permit(:name, :char_class, :level)
  end
end