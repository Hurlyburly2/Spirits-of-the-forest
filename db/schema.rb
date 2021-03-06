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

ActiveRecord::Schema.define(version: 2019_05_10_190202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appstamps", force: :cascade do |t|
    t.datetime "last_activity_check"
  end

  create_table "cards", force: :cascade do |t|
    t.string "spirit", null: false
    t.integer "spirit_points", null: false
    t.integer "spirit_count", null: false
    t.string "element", null: false
    t.string "image_url", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "gamestate"
    t.integer "whose_turn_id"
    t.integer "winner_id"
    t.boolean "concession", default: false
    t.boolean "gem_placed", default: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "endgame_confirm", default: false
    t.text "selected_cards"
    t.text "tokens"
    t.boolean "reminded", default: false
    t.integer "gems_possessed", default: 3
    t.integer "gems_total", default: 3
    t.index ["game_id"], name: "index_matches_on_game_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "spirit", null: false
    t.string "image_url", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.string "rank", default: "bronze"
    t.integer "rankup_score", default: 0
    t.boolean "reminders", default: false
    t.integer "which_profile_pic"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
