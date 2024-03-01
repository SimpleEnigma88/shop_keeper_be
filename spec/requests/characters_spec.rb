require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  let(:player) { Player.create!(user_name: Faker::Internet.user_name, email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)}
  let(:valid_attributes) { { name: 'CharacterName', char_class: 'Warrior', level: 1, player_id: player.id } }
  let(:invalid_attributes) { { name: nil, char_class: nil, level: nil, player_id: nil } }

  describe "GET #index" do
    it "returns a success response" do
      Character.create! valid_attributes
      get :index, params: { player_id: player.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      character = Character.create! valid_attributes
      get :show, params: { id: character.to_param, player_id: player.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Character" do
        expect {
          post :create, params: { character: valid_attributes, player_id: player.id }
        }.to change(Character, :count).by(1)
      end

      it "renders a JSON response with the new character" do
        post :create, params: { character: valid_attributes, player_id: player.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Character" do
        expect {
          post :create, params: { character: invalid_attributes, player_id: player.id }
        }.to change(Character, :count).by(0)
      end

      it "renders a JSON response with errors for the new character" do
        post :create, params: { character: invalid_attributes, player_id: player.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: 'NewCharacterName' } }

      it "updates the requested character" do
        character = Character.create! valid_attributes
        patch :update, params: { id: character.to_param, character: new_attributes, player_id: player.id }
        character.reload
        expect(character.name).to eq('NewCharacterName')
      end

      it "renders a JSON response with the character" do
        character = Character.create! valid_attributes
        patch :update, params: { id: character.to_param, character: new_attributes, player_id: player.id }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the character" do
        character = Character.create! valid_attributes
        patch :update, params: { id: character.to_param, character: invalid_attributes, player_id: player.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested character" do
      character = Character.create! valid_attributes
      expect {
        delete :destroy, params: { id: character.to_param, player_id: player.id }
      }.to change(Character, :count).by(-1)
    end
  end
end