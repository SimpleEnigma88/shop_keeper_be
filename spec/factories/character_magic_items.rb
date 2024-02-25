FactoryBot.define do
  factory :character_magic_item do
    association :character
    association :magic_item
  end
end