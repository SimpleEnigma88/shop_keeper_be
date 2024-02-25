FactoryBot.define do
  factory :party do
    name { Faker::Games::DnD.unique.city }
    dm_player { create(:player) }

    after(:create) do |party|
      create_list(:character, rand(7), party: party)
    end
  end
end