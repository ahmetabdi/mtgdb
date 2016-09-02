# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160901192845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "magic_cards", force: :cascade do |t|
    t.string  "unique_id"
    t.string  "layout"
    t.string  "name"
    t.string  "names"
    t.string  "mana_cost"
    t.string  "cmc"
    t.string  "colors"
    t.string  "color_identity"
    t.string  "type_of_card"
    t.string  "supertypes"
    t.string  "types"
    t.string  "subtypes"
    t.string  "rarity"
    t.string  "text"
    t.string  "flavor"
    t.string  "artist"
    t.string  "number"
    t.string  "power"
    t.string  "toughness"
    t.string  "loyalty"
    t.string  "multiverse_id"
    t.string  "variations"
    t.string  "image_name"
    t.string  "watermark"
    t.string  "border"
    t.string  "timeshifted"
    t.string  "hand"
    t.string  "life"
    t.boolean "reserved"
    t.string  "release_date"
    t.boolean "starter"
    t.string  "mci_number"
    t.integer "magic_set_id"
    t.index ["magic_set_id"], name: "index_magic_cards_on_magic_set_id", using: :btree
  end

  create_table "magic_sets", force: :cascade do |t|
    t.string  "name"
    t.string  "code"
    t.string  "gatherer_code"
    t.string  "old_code"
    t.string  "magic_cards_info_code"
    t.date    "release_date"
    t.string  "border"
    t.string  "type_of_set"
    t.string  "block"
    t.boolean "online_only"
    t.string  "booster"
    t.string  "mkm_name"
    t.string  "mkm_id"
    t.string  "magic_rarities_codes"
  end

  add_foreign_key "magic_cards", "magic_sets"
end
