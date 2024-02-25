FactoryBot.define do
  factory :magic_item do
    name { Faker::Lorem.word }
    category { ["Armor", "Potion", "Ring", "Rod", "Scroll", "Staff", "Wand", "Weapon", "Wondrous item"].sample }
    desc { Faker::Lorem.sentence }
    rarity { ["Common", "Uncommon", "Rare", "Very rare", "Artifact", "Legendary"].sample }
    requires_attunement { true }

  end
end