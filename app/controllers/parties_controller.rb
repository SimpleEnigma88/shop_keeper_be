class PartiesController < ApplicationController
  before_action :set_player, only: %i[index show create update destroy]

  # Show all dm_parties belonging to player, or the party for charcter id, when provided.
  def index
    if params[:player_id]
      @player = Player.find(params[:player_id])
      puts "player_id: #{params[:player_id]}, player: #{@player.inspect}"
      @parties = @player.dm_parties
    elsif params[:character_id]
      @character = Character.find(params[:character_id])
      @parties = @character.parties
    end
    render json: @parties, status: :ok
  end

  def show
    if params[:player_id]
      @player = Player.find(params[:player_id])
      @party = @player.dm_parties.find(params[:id])
    elsif params[:character_id]
      @character = Character.find(params[:character_id])
      @party = @character.parties.find(params[:id])
    end
    render json: @party, status: :ok
  end

  def create
    party = @player.dm_parties.new(party_params)

    if party.save
      render json: party, status: :created
    else
      render json: party.errors, status: :unprocessable_entity
    end
  end

  def update
    party = @player.parties.find(params[:id])

    if party.update(party_params)
      render json: party, status: :ok
    else
      render json: party.errors, status: :unprocessable_entity
    end
  end

  def destroy
    party = @player.parties.find(params[:id])

    if party.destroy
      render json: party, status: :ok
    else
      render json: party.errors, status: :unprocessable_entity
    end
  end

  private

  def set_player
    @player = Player.find_by(id: params[:player_id]) ||
              Player.find_by(id: params[:dm_player_id])
  end

  def set_character
    # Use find_by to return nil, instead of throwing an error, if the character_id is not found
    @character = Character.find_by(id: params[:character_id])
  end

  def party_params
    params.require(:party).permit(:name, :dm_player_id)
  end
end
