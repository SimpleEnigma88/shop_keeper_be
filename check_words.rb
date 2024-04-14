# already_output = Set.new

# File.open('db/seeds/tableData.txt', 'r') do |file|
#   file.each_line do |line|
#     phrases = line.split(',')
#     phrases.each do |phrase|
#       # Remove non-alphabetic characters and extra whitespace
#       clean_phrase = phrase.gsub(/[^a-zA-Z ]/, '').strip
#       words = clean_phrase.split
#       words.each do |word|
#         unless MagicItem.where('name LIKE ?', "%#{word}%").exists? || already_output.include?(word)
#           puts "Word not found: #{word}"
#           already_output.add(word)
#         end
#       end
#     end
#   end
# end

MagicItem.where("rarity LIKE '% %' AND rarity <> 'very rare'").find_each do |item|
  words = item.rarity.split
  words.each do |word|
    next unless ['common', 'uncommon', 'rare', 'very rare'].include?(word)

    new_item = item.dup
    new_item.rarity = word
    if new_item.save
      puts "Created new item with ID #{new_item.id}, category '#{new_item.category}', name '#{new_item.name}', and rarity '#{new_item.rarity}'"
    else
      puts "Failed to create new item: #{new_item.errors.full_messages.join(", ")}"
    end
  end
end