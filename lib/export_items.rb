# Define the rarities
rarities = ['common', 'uncommon', 'rare', 'very rare']

# Select all items where the rarity is 'varies'
items = MagicItem.where(rarity: 'varies')

# Process each item
items.find_each do |item|
  # Initialize the flag
  all_saves_successful = true

  # Check each rarity
  rarities.each do |rarity|
    # If the description contains the rarity
    next unless item.desc.downcase.include?("(#{rarity})")

    # Create a new item that is a copy of the original item, with the rarity set to the detected rarity
    new_item = item.dup
    new_item.rarity = rarity
    unless new_item.save
      puts "Failed to create new item: #{new_item.errors.full_messages.join(', ')}"
      all_saves_successful = false
    end
  end

  # If all saves were successful, delete the original item
end
