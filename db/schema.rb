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

ActiveRecord::Schema[8.0].define(version: 2026_04_03_091037) do
  create_table "matches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "player_a_id"
    t.bigint "player_b_id"
    t.bigint "winner_id"
    t.bigint "loser_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loser_id"], name: "fk_rails_973a5646ac"
    t.index ["player_a_id"], name: "fk_rails_84cb577c99"
    t.index ["player_b_id"], name: "fk_rails_1609b0379a"
    t.index ["winner_id"], name: "fk_rails_9d0deeb219"
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.string "phone", null: false
    t.index ["created_by_id"], name: "index_players_on_created_by_id"
    t.index ["updated_by_id"], name: "index_players_on_updated_by_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
  end

  add_foreign_key "matches", "players", column: "loser_id"
  add_foreign_key "matches", "players", column: "player_a_id"
  add_foreign_key "matches", "players", column: "player_b_id"
  add_foreign_key "matches", "players", column: "winner_id"
  add_foreign_key "players", "users", column: "created_by_id"
  add_foreign_key "players", "users", column: "updated_by_id"
end
