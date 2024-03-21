require 'rails_helper'

RSpec.describe MagicItemsController, type: :controller do
  let(:valid_attributes) do
    { name: 'Magic Sword', category: 'Weapon', desc: 'A magical sword', rarity: 'Rare', requires_attunement: false }
  end

  let(:invalid_attributes) do
    { name: nil, category: 'Weapon', desc: 'A magical sword', rarity: 'Rare', requires_attunement: false }
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all magic items' do
      magic_items = Array.new(3) { MagicItem.create! valid_attributes }
      get :index
      expect(JSON.parse(response.body).size).to eq(magic_items.size)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      magic_item = MagicItem.create! valid_attributes
      get :show, params: { id: magic_item.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new MagicItem' do
        expect do
          post :create, params: { magic_item: valid_attributes }
        end.to change(MagicItem, :count).by(1)
      end

      it 'renders a JSON response with the new magic_item' do
        post :create, params: { magic_item: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new MagicItem' do
        expect do
          post :create, params: { magic_item: invalid_attributes }
        end.to change(MagicItem, :count).by(0)
      end

      it 'renders a JSON response with the new magic_item' do
        post :create, params: { magic_item: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'New Magic Sword' }
      end

      it 'updates the requested magic_item' do
        magic_item = MagicItem.create! valid_attributes
        patch :update, params: { id: magic_item.to_param, magic_item: new_attributes }
        magic_item.reload
        expect(magic_item.name).to eq('New Magic Sword')
      end

      it 'renders a JSON response with the updated magic_item' do
        magic_item = MagicItem.create! valid_attributes
        patch :update, params: { id: magic_item.to_param, magic_item: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the magic_item' do
        magic_item = MagicItem.create! valid_attributes
        patch :update, params: { id: magic_item.to_param, magic_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested magic_item' do
      magic_item = MagicItem.create! valid_attributes
      expect do
        delete :destroy, params: { id: magic_item.to_param }
      end.to change(MagicItem, :count).by(-1)
    end
  end

  it 'returns a random magic_item with the specified rarity' do
    very_rare_item1 = MagicItem.create!(valid_attributes.merge(rarity: 'very rare'))
    very_rare_item2 = MagicItem.create!(valid_attributes.merge(rarity: 'very rare'))
    get '/magic_items/random', params: { rarity: 'very rare' }
    expect(response).to be_successful
    json_response = JSON.parse(response.body)
    expect([very_rare_item1.id, very_rare_item2.id]).to include(json_response['id'])
  end
end
