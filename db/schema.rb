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

ActiveRecord::Schema[7.2].define(version: 2024_08_26_222919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.bigint "dm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dm_id"], name: "index_games_on_dm_id"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "alignment"
    t.integer "armor_class"
    t.integer "hit_points"
    t.integer "speed"
    t.string "resistances"
    t.integer "p_bonus"
    t.string "attacks"
    t.boolean "displayed"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_monsters_on_game_id"
  end

  create_table "player_conditions", force: :cascade do |t|
    t.integer "condition_length"
    t.bigint "condition_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["condition_id"], name: "index_player_conditions_on_condition_id"
    t.index ["player_id"], name: "index_player_conditions_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "character"
    t.string "image"
    t.integer "level"
    t.integer "current_hp"
    t.integer "total_hp"
    t.integer "armor_class"
    t.integer "speed"
    t.integer "initiative_bonus"
    t.integer "strength"
    t.integer "str_bonus"
    t.integer "str_save"
    t.integer "dexterity"
    t.integer "dex_bonus"
    t.integer "dex_save"
    t.integer "constitution"
    t.integer "con_bonus"
    t.integer "con_save"
    t.integer "intelligence"
    t.integer "int_bonus"
    t.integer "int_save"
    t.integer "wisdom"
    t.integer "wis_bonus"
    t.integer "wis_save"
    t.integer "charisma"
    t.integer "cha_bonus"
    t.integer "cha_save"
    t.boolean "displayed"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "users", column: "dm_id"
end
