require 'rails_helper'

RSpec.describe Character, type: :model do
  let(:character) { build(:character) }

  it 'is valid with valid attributes' do
    expect(character).to be_valid
  end

  it 'is not valid without a name' do
    character.name = nil
    expect(character).not_to be_valid
  end

  it 'is not valid without a char_class' do
    character.char_class = nil
    expect(character).not_to be_valid
  end

  it 'is not valid without a level' do
    character.level = nil
    expect(character).not_to be_valid
  end

  it 'is not valid without a player' do
    character.player = nil
    expect(character).not_to be_valid
  end

  it 'can belong to a party' do
    party = create(:party)
    character = create(:character)
    character.party = party
    expect(character.party).to eq party
  end

  it 'can have many magic_items' do
    character = create(:character)
    magic_item1 = create(:magic_item)
    magic_item2 = create(:magic_item)
    character.magic_items << [magic_item1, magic_item2]
    expect(character.magic_items).to include(magic_item1, magic_item2)
  end

end