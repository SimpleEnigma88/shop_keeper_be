class MagicItemsController < ApplicationController
  def index
    @magic_items = MagicItem.all
    render json: @magic_items
  end

  def show
    @magic_item = MagicItem.find(params[:id])
    render json: @magic_item
  end

  def random
    excluded_rarities = params[:excluded_rarities].split(',')
    magic_item = MagicItem.where.not(rarity: excluded_rarities).order('RANDOM()').first
    render json: magic_item
  end

  def edit
    @magic_item = MagicItem.find(params[:id])
    if @magic_item.update(magic_item_params)
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  def create
    @magic_item = MagicItem.new(magic_item_params)
    if @magic_item.save
      render json: @magic_item, status: :created
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  def update
    @magic_item = MagicItem.find(params[:id])
    if @magic_item.update(magic_item_params)
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @magic_item = MagicItem.find(params[:id])
    if @magic_item.destroy
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  private

  def magic_item_params
    params.require(:magic_item).permit(:name, :category, :desc, :rarity, :requires_attunement)
  end
end
