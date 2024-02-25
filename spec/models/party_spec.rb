require 'rails_helper'

RSpec.describe Party, type: :model do
  let(:party) { build(:party) }
  
  it 'is valid with valid attributes' do
    expect(party).to be_valid
  end

  it 'is not valid without a name' do
    party.name = nil
    expect(party).not_to be_valid
  end

  it 'is not valid without a dm_player_id' do
    party.dm_player_id = nil
    expect(party).not_to be_valid
  end

  it 'has many characters' do
    character1 = create(:character)
    character2 = create(:character)
    party.characters << [character1, character2]
    expect(party.characters).to include(character1, character2)
  end

  it 'belongs to a dm_player' do
    player = create(:player)
    party.dm_player = player
    expect(party.dm_player).to eq player
  end
end