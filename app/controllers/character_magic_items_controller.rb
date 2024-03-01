class CharacterMagicItemsController < ApplicationController
  before_action :set_character

  def create
    magic_item = MagicItem.find(params[:magic_item_id])
    @character.magic_items << magic_item

    if @character.save
      render json: @character, status: :created
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