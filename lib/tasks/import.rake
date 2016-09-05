require 'net/http'
require 'zip'

namespace :import do
  desc "Downloads and imports all sets and cards from mtgjson.com"
  task run: :environment do
    # Sets to download - Currently everything in standard
    sets_to_download = ['DTK', 'ORI', 'BFZ', 'OGW', 'W16', 'SOI', 'EMN']

    sets_to_download.each do |set_name|
      # Delete existing files before we start
      if File.exists? "public/importer/#{set_name}.json"
        File.delete "public/importer/#{set_name}.json"
      end

      if File.exists? "public/importer/#{set_name}.zip"
        File.delete "public/importer/#{set_name}.zip"
      end

      # Fetch ZIP for the current SET to be downloaded
      uri = URI("https://mtgjson.com/json/#{set_name}-x.json.zip")
      zipped_folder = Net::HTTP.get(uri)

      File.open("public/importer/#{set_name}.zip", 'wb') do |file|
        file.write(zipped_folder)
      end

      # Extra fetched ZIP to a JSON file
      zip_file = Zip::File.open("public/importer/#{set_name}.zip")
      zip_file.each do |file|
        file.extract("public/importer/#{set_name}.json")
      end

      # Remove UNZIPPED ZIP as it's no longer needed
      if File.exists? "public/importer/#{set_name}.zip"
        File.delete "public/importer/#{set_name}.zip"
      end

      # Parse the JSON file and start importing the data
      file = File.read("public/importer/#{set_name}.json")
      data = JSON.parse(file)

      magic_set = MagicSet.where(code: data['code']).first_or_initialize.tap do |set|
        set.name = data['name']
        set.code = data['code']
        set.gatherer_code = data['gathererCode']
        set.old_code = data['oldCode']
        set.magic_cards_info_code = data['magicCardsInfoCode']
        set.release_date = data['releaseDate']
        set.border = data['border']
        set.type_of_set = data['type']
        set.block = data['block']
        set.online_only = data['onlineOnly']
        set.booster = data['booster']
        set.mkm_name = data['mkm_name']
        set.mkm_id = data['mkm_id']
        set.magic_rarities_codes = data['magicRaritiesCodes']
        set.save
      end

      data['cards'].each do |value|
        puts "#{data['name']} - #{value['name']}"
        MagicCard.where(unique_id: value['id']).first_or_initialize.tap do |card|
          card.unique_id = value['id']
          card.layout = value['layout']
          card.name = value['name']
          card.names = value['names']
          card.mana_cost = value['manaCost']
          card.cmc = value['cmc']
          card.colors = value['colors']
          card.color_identity = value['colorIdentity']
          card.type_of_card = value['type']
          card.supertypes = value['supertypes']
          card.types = value['types']
          card.subtypes = value['subtypes']
          card.rarity = value['rarity']
          card.text = value['text']
          card.flavor = value['flavor']
          card.artist = value['artist']
          card.number = value['number']
          card.power = value['power']
          card.toughness = value['toughness']
          card.loyalty = value['loyalty']
          card.multiverse_id = value['multiverseid']
          card.variations = value['variations']
          card.image_name = value['imageName']
          card.watermark = value['watermark']
          card.border = value['border']
          card.timeshifted = value['timeshifted']
          card.hand = value['hand']
          card.life = value['life']
          card.reserved = value['reserved']
          card.release_date = value['releaseDate']
          card.starter = value['starter']
          card.mci_number = value['mciNumber']
          card.rulings = value['rulings']
          card.foreign_names = value['foreignNames']
          card.printings = value['printings']
          card.original_text = value['originalText']
          card.original_type = value['originalType']
          card.legalities = value['legalities']
          card.promo_source = value['source']
          card.magic_set_id = magic_set.id
          card.save
        end
      end

      if File.exists? "public/importer/#{set_name}.json"
        File.delete "public/importer/#{set_name}.json"
      end
    end
  end
end
