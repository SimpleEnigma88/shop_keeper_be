FactoryBot.define do
  factory :character do
    name { Faker::Games::DnD.unique.name }
    char_class { Faker::Games::DnD.klass }
    level { rand(1..20) }
    association :player, factory: :player, strategy: :build # Built but not saved to DB
  end
end
