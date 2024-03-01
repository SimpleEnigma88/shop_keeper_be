# spec/controllers/players_controller_spec.rb
require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let(:valid_attributes) { attributes_for(:player) }
  let(:invalid_attributes) { { user_name: nil } }

  describe "GET #index" do
    it "returns a success response" do
      Player.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      player = Player.create! valid_attributes
      get :show, params: { id: player.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Player" do
        expect {
          post :create, params: { player: valid_attributes }
        }.to change(Player, :count).by(1)
      end

      it "renders a JSON response with the new player" do
        post :create, params: { player: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Player" do
        expect {
          post :create, params: { player: invalid_attributes }
        }.to change(Player, :count).by(0)
      end

      it "renders a JSON response with errors for the new player" do
        post :create, params: { player: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with duplicate email address" do
      it "does not create a new Player" do
        player = Player.create! valid_attributes
        duplicate_attributes = valid_attributes.merge(email: player.email)
        expect {
          post :create, params: { player: duplicate_attributes }
        }.to change(Player, :count).by(0)
      end

      it "renders a JSON response with errors for the new player" do
        player = Player.create! valid_attributes
        duplicate_attributes = valid_attributes.merge(email: player.email)
        post :create, params: { player: duplicate_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with duplicate user_name" do
      it "does not create a new Player" do
        player = Player.create! valid_attributes
        duplicate_attributes = valid_attributes.merge(user_name: player.user_name)
        expect {
          post :create, params: { player: duplicate_attributes }
        }.to change(Player, :count).by(0)
      end

      it "renders a JSON response with errors for the new player" do
        player = Player.create! valid_attributes
        duplicate_attributes = valid_attributes.merge(user_name: player.user_name)
        post :create, params: { player: duplicate_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) { { user_name: 'NewUserName' } }

      it "updates the requested player" do
        player = Player.create! valid_attributes
        put :update, params: { id: player.to_param, player: new_attributes }
        player.reload
        expect(player.user_name).to eq('NewUserName')
      end

      it "renders a JSON response with the player" do
        player = Player.create! valid_attributes
        put :update, params: { id: player.to_param, player: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the player" do
        player = Player.create! valid_attributes
        put :update, params: { id: player.to_param, player: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested player" do
      player = Player.create! valid_attributes
      expect {
        delete :destroy, params: { id: player.to_param }
      }.to change(Player, :count).by(-1)
    end
  end
end