class PlayersController < ApplicationController
  before_action :set_player, only: %i[show update destroy]
  before_action :authenticate_request, only: %i[index show update destroy]

  def index
    players = Player.all
    render json: players
  end

  def show
    if @player
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def create
    player = Player.create(player_params)

    if player.save
      render json: player, status: :created
    else
      puts player.errors
      render json: player.errors, status: :unprocessable_entity
    end
  end

  def update
    if @player.update(player_params)
      render json: @player, status: :ok
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @player = Player.find(params[:id])
    copy_characters_and_items(@player)
    destroy_player(@player)
  end

  private

  def copy_characters_and_items(player)
    player.characters.where.not(party_id: nil).each do |character|
      copied_character = copy_character(character)
      copy_magic_items(character, copied_character)
    end
  end

  def copy_character(character)
    copied_character = character.dup
    copied_character.save!
    copied_character
  end

  def copy_magic_items(character, copied_character)
    character.magic_items.each do |magic_item|
      copied_magic_item = magic_item.dup
      copied_magic_item.character_id = copied_character.id
      copied_magic_item.save!
    end
  end

  def destroy_player(player)
    if player.destroy
      render json: player
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:user_name, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
