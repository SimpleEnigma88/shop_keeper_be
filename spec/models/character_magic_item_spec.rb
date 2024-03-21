require 'rails_helper'

RSpec.describe CharacterMagicItem, type: :model do
  let(:player) { create(:player) }
  let(:character) { create(:character) }
  let(:magic_item) { create(:magic_item) }
  let(:character_magic_item) { build(:character_magic_item) }

  it 'is valid with valid attributes' do
    expect(character_magic_item).to be_valid
  end

  it 'is not valid without a character' do
    character_magic_item.character = nil
    expect(character_magic_item).not_to be_valid
  end

  it 'is not valid without a magic_item' do
    character_magic_item.magic_item = nil
    expect(character_magic_item).not_to be_valid
  end

  it 'belongs to a character' do
    character = create(:character)
    character_magic_item = create(:character_magic_item, character:)
    expect(character_magic_item.character).to eq(character)
  end

  it 'belongs to a magic_item' do
    magic_item = create(:magic_item)
    character_magic_item = create(:character_magic_item, magic_item:)
    expect(character_magic_item.magic_item).to eq(magic_item)
  end
end
