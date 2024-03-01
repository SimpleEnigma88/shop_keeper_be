require 'rails_helper'

RSpec.describe CharacterMagicItemsController, type: :controller do

  let(:player) { Player.create!(
  user_name: Faker::Internet.user_name, 
  email: Faker::Internet.email, 
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name) }

  let(:character) { Character.create!(
  name: 'CharacterName', 
  char_class: 'Warrior', 
  level: 1, 
  player_id: player.id) }

  let(:magic_item) { MagicItem.create!(
  name: "Turtle Hat", 
  category: "Armor", 
  desc: "A hat for a Turtle", 
  rarity: "Common", 
  requires_attunement: false) }

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