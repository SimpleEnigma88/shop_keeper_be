FactoryBot.define do
  factory :player do
    user_name { Faker::Internet.username }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

  end
end