# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'json'

path = Rails.root.join('db', 'seeds', 'ModifiedMagicItems.json')
records = JSON.parse(File.read(path))

ActiveRecord::Base.transaction do
  records.each do |record_data|
    filtered_data = {
      name: record_data["name"],
      category: record_data["type"],
      desc: record_data["desc"], 
      rarity: record_data["rarity"],
      requires_attunement: record_data["requires_attunement"]
    }

    MagicItem.destroy_all
    
    begin
      MagicItem.create!(filtered_data)
    rescue ActiveRecord::RecordInvalid => e
      puts "An error occurred while creating the record: #{e.message}"
      # Optionally log the record that failed to aid debugging
      puts "Failed record data: #{filtered_data.inspect}"
      raise ActiveRecord::Rollback
    end
  end
end


# Seed Players
10.times do
  Player.create!(
    user_name: Faker::Internet.username,
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end


Player.all.each do |player|
  rand(1..3).times do
    begin
      Character.create!(
        name: Faker::Games::DnD.first_name,
        char_class: Faker::Games::DnD.klass,
        level: rand(1..20),
        player: player
      )
    rescue ActiveRecord::RecordInvalid => e
      puts "Failed to create character for player #{player.id}: #{e.message}"
    end
  end
end

players = Player.all.shuffle

players.each_with_index do |player, index|
  # Only create a party for 1 out of every 1-3 players
  next unless index % rand(1..3) == 0

  party = Party.create!(
    name: Faker::Games::DnD.city,
    dm_player: player
  )

  # Select characters from different players
  characters = players.sample(rand(2..5)).map do |p|
    p.characters.sample
  end

  # 35% of the time, add the DM's character to the party
  if rand < 0.35 && player.characters.any?
    characters << player.characters.sample
  end

  characters.each do |character|
    character.update!(party: party)

    # Assign a random number of magic items from the magic_items table to each character
    magic_items = MagicItem.order("RANDOM()").limit(rand(1..5))
    character.magic_items << magic_items
  end
end