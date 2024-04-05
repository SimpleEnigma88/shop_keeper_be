namespace :db do
  desc 'Export magic_items data to a seed file'
  task export_magic_items: :environment do
    File.open('db/magic_items_seed.rb', 'w') do |file|
      MagicItem.find_each do |magic_item|
        file.write("MagicItem.create!(#{magic_item.attributes.except('id', 'created_at', 'updated_at').inspect})\n")
      end
    end
  end
end
