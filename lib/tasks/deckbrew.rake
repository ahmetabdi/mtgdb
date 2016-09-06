namespace :deckbrew do
  desc "TODO"
  task import_images: :environment do
    multiverse_ids = MagicCard.pluck(:multiverse_id).compact
    multiverse_ids.each do |m_id|
      next if File.exists? "public/importer/#{m_id}.jpg"
      puts m_id
      open("https://image.deckbrew.com/mtg/multiverseid/#{m_id}.jpg") do |u|
        File.open("public/importer/#{m_id}.jpg", 'wb') { |f| f.write(u.read) }
      end
    end
  end
end
