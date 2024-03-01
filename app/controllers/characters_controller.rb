class CharactersController < ApplicationController
  before_action :set_player, only: [:index, :show, :create, :update, :destroy]
  
  def index
    characters = @player.characters
    render json: characters, status: :ok
  end

  def show
    character = @player.characters.find(params[:id])
    render json: character, status: :ok
  end

  def create
    character = @player.characters.new(character_params)

    if character.save
      render json: character, status: :created
    else
      render json: character.errors, status: :unprocessable_entity
    end
  end

  def update
    character = @player.characters.find(params[:id])

    if character.update(character_params)
        render json: character, status: :ok
    else
        render json: character.errors, status: :unprocessable_entity
    end
  end

  def destroy
    character = @player.characters.find(params[:id])

    if character.destroy
      render json: character, status: :ok
    else
      render json: character.errors, status: :unprocessable_entity
    end
  end

  private

  def set_player
    @player = Player.find(params[:player_id])
  end

  def character_params
    params.require(:character).permit(:name, :char_class, :level)
  end
end