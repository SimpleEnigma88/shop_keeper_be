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
          render json: player
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

  # def destroy
  #   player = Player.find(params[:id])

  #   if player.destroy
  #     render json: player
  #   else
  #     render json: player.errors, status: :unprocessable_entity
  #   end
  # end

  private
  
  def player_params
      params.require(:player).permit(:user_name, :email, :first_name, :last_name)
  end
end
