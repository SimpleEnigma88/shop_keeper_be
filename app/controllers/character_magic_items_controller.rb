class CharacterMagicItemsController < ApplicationController
  before_action :set_character
  # before_action :authenticate_request, only: %i[index show create destroy]

  def index
    if @character.magic_items
      @character_magic_items = @character.magic_items
      render json: @character_magic_items, status: :ok
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def show
    if @character.magic_items
      @character_magic_item = @character.magic_items.find(params[:id])
      render json: @character_magic_item, status: :ok
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def create
    magic_item = MagicItem.find(params[:magic_item_id])
    @character.magic_items << magic_item

    if @character.save
      render json: magic_item, status: :created
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def destroy
    magic_item = MagicItem.find(params[:id])
    @character.magic_items.destroy(magic_item)

    head :no_content
  end

  private

  def set_character
    @character = Character.find(params[:character_id])
  end
end
