namespace :import do
  desc "TODO"
  task all: :environment do
    file = File.read(Rails.root.join('lib', 'AllSets.json'))
    data = JSON.parse(file)

    data.each do |key,value|
      magic_set = MagicSet.where(code: value['code']).first_or_create! do |set|
        set.name = value['name']
        set.code = value['code']
        set.gatherer_code = value['gathererCode']
        set.old_code = value['oldCode']
        set.magic_cards_info_code = value['magicCardsInfoCode']
        set.release_date = value['releaseDate']
        set.border = value['border']
        set.type_of_set = value['type']
        set.block = value['block']
        set.online_only = value['onlineOnly']
        set.booster = value['booster']
        set.mkm_name = value['mkm_name']
        set.mkm_id = value['mkm_id']
        set.magic_rarities_codes = value['magicRaritiesCodes']
      end

      value['cards'].each do |value|
        puts value['name']
        MagicCard.where(unique_id: value['id']).first_or_create! do |card|
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
          card.magic_set_id = magic_set.id
        end
      end
    end
  end
end
