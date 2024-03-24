require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /login' do
    let(:player) { create(:player) }

    it 'authenticates the user and returns a success response' do
      post '/login', params: { username: player.user_name, password: player.password }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('token')
    end

    it 'does not authenticate the user and returns an error response' do
      post '/login', params: { username: player.user_name, password: 'wrong_password' }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to include('error')
    end
  end
end
