# spec/models/player_spec.rb
require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { build(:player) }

  it 'is valid with valid attributes' do
    expect(player).to be_valid
  end

  # Test for validations
  it 'is not valid without a user_name' do
    player.user_name = nil
    expect(player).not_to be_valid
  end

  it 'is not valid without a first name' do
    player.first_name = nil
    expect(player).not_to be_valid
  end
  
  it 'is not valid without a last name' do
    player.last_name = nil
    expect(player).not_to be_valid
  end
  
  it 'is not valid without an email' do
    player.email = nil
    expect(player).not_to be_valid
  end
  
  it 'is not valid with a duplicate email' do
    create(:player, email: 'test@example.com')
    player.email = 'test@example.com'
    expect(player).not_to be_valid
  end
  # Test for associations
  it 'can have many characters' do
    player = create(:player)
    player.characters.create!(name: 'Character 1', char_class: 'Wizard', level: 1)
    player.characters.create!(name: 'Character 2', char_class: 'Barbarian', level: 2)

    expect(player.characters.length).to eq 2
  end

  it 'can be a DM for many parties' do
    player = create(:player)
    player.dm_parties.create!(name: 'Party 1')
    player.dm_parties.create!(name: 'Party 2')

    expect(player.dm_parties.length).to eq 2
  end
end