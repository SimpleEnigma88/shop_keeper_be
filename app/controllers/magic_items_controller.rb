class MagicItemsController < ApplicationController
  def index
    @magic_items = MagicItem.all
    render json: @magic_items
  end

  def show
    @magic_item = find_magic_item
    render_magic_item
  end

  def edit
    @magic_item = find_magic_item
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
    @magic_item = find_magic_item
    if @magic_item.update(magic_item_params)
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @magic_item = find_magic_item
    if @magic_item.destroy
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  private

  def find_magic_item
    if params[:id] == 'random'
      find_random_magic_item
    else
      MagicItem.find(params[:id])
    end
  end

  def render_magic_item
    if @magic_item
      render json: @magic_item
    else
      render json: @magic_item.errors, status: :unprocessable_entity
    end
  end

  # params should be a string of rarities separated by commas
  def find_random_magic_item
    if params[:rarities]&.any?
      rarities = params[:rarity].split(',')
      @magic_item = MagicItem.where(rarity: rarities).order(Arel.sql('RANDOM()')).first
    else
      @magic_item = MagicItem.order(Arel.sql('RANDOM()')).first
    end
  end

  def magic_item_params
    params.require(:magic_item).permit(:name, :category, :desc, :rarity, :requires_attunement)
  end
end
