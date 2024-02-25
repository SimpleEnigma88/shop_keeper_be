# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_25_012455) do
  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "char_class"
    t.integer "level"
    t.integer "player_id", null: false
    t.integer "party_id"
    t.integer "magic_item_id"
    t.integer "mundane_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["magic_item_id"], name: "index_characters_on_magic_item_id"
    t.index ["mundane_item_id"], name: "index_characters_on_mundane_item_id"
    t.index ["party_id"], name: "index_characters_on_party_id"
    t.index ["player_id"], name: "index_characters_on_player_id"
  end

  create_table "magic_items", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.text "desc"
    t.string "rarity"
    t.boolean "requires_attunement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mundane_items", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parties", force: :cascade do |t|
    t.integer "dm_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["dm_player_id"], name: "index_parties_on_dm_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "magic_items"
  add_foreign_key "characters", "mundane_items"
  add_foreign_key "characters", "parties"
  add_foreign_key "characters", "players"
  add_foreign_key "parties", "players", column: "dm_player_id"
end
