class CreateMagicCards < ActiveRecord::Migration[5.0]
  def change
    create_table :magic_cards do |t|
      t.string :unique_id
      t.string :layout
      t.string :name
      t.string :names
      t.string :mana_cost
      t.string :cmc
      t.string :colors
      t.string :color_identity
      t.string :type_of_card
      t.string :supertypes
      t.string :types
      t.string :subtypes
      t.string :rarity
      t.string :text
      t.string :flavor
      t.string :artist
      t.string :number
      t.string :power
      t.string :toughness
      t.string :loyalty
      t.string :multiverse_id
      t.string :variations
      t.string :image_name
      t.string :watermark
      t.string :border
      t.string :timeshifted
      t.string :hand
      t.string :life
      t.boolean :reserved
      t.string :release_date
      t.boolean :starter
      t.string :mci_number

      t.references :magic_set, foreign_key: true
    end
  end
end
