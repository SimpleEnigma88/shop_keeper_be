require 'rails_helper'
require 'faker'

RSpec.describe CharacterMagicItemsController, type: :controller do

  let(:player) { Player.create!(
  user_name: Faker::Internet.user_name, 
  email: Faker::Internet.email, 
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name) }

  let(:character) { Character.create!(
  name: Faker::Games::DnD.first_name, 
  char_class: Faker::Games::DnD.klass, 
  level: rand(1..20),  
  player_id: player.id) }

  let(:magic_item) { MagicItem.create!(
  name: Faker::Games::DnD.melee_weapon, 
  category: Faker::Games::DnD.race, 
  desc: Faker::Games::DnD.ranged_weapon, 
  rarity: Faker::Games::DnD.background, 
  requires_attunement: false) }

  describe "GET #index" do
  it "returns a success response" do
    character.magic_items << magic_item
    get :index, params: { character_id: character.id }
    
    expect(response).to be_successful
    expect(response.content_type).to match(a_string_including("application/json"))
  end
end

describe "GET #show" do
  it "returns a success response" do
    character.magic_items << magic_item
    get :show, params: { character_id: character.id, id: magic_item.id }

    expect(response).to be_successful
    expect(response.content_type).to match(a_string_including("application/json"))
  end
end

  describe "POST #create" do
    it "assigns a magic item to a character" do
      post :create, params: { character_id: character.id, magic_item_id: magic_item.id }

      expect(response).to have_http_status(:created)
      expect(character.magic_items).to include(magic_item)
    end
  end

  describe "DELETE #destroy" do
    it "removes a magic item from a character" do
      character.magic_items << magic_item
      delete :destroy, params: { character_id: character.id, id: magic_item.id }

      expect(response).to have_http_status(:no_content)
      expect(character.magic_items).not_to include(magic_item)
    end
  end
end