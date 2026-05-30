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

ActiveRecord::Schema[8.1].define(version: 2024_00_01_000013) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "riddle_id", null: false
    t.string "text", null: false
    t.datetime "updated_at", null: false
    t.index ["riddle_id"], name: "index_answers_on_riddle_id"
  end

  create_table "auction_listings", force: :cascade do |t|
    t.integer "buyer_id"
    t.datetime "created_at", null: false
    t.integer "inventory_id", null: false
    t.integer "price", null: false
    t.integer "seller_id", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_auction_listings_on_buyer_id"
    t.index ["inventory_id"], name: "index_auction_listings_on_inventory_id"
    t.index ["seller_id"], name: "index_auction_listings_on_seller_id"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "base_hp", default: 10, null: false
    t.integer "base_strength", default: 10, null: false
    t.datetime "created_at", null: false
    t.integer "experience", default: 0, null: false
    t.integer "gold", default: 0, null: false
    t.integer "level", default: 1, null: false
    t.string "name", null: false
    t.integer "unspent_points", default: 10, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "combat_sessions", force: :cascade do |t|
    t.integer "character_hp", null: false
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.text "log"
    t.integer "npc_hp", null: false
    t.integer "npc_id", null: false
    t.string "status", default: "ongoing", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_combat_sessions_on_character_id"
    t.index ["npc_id"], name: "index_combat_sessions_on_npc_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.boolean "equipped", default: false, null: false
    t.integer "item_id", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id", "item_id"], name: "index_inventories_on_character_id_and_item_id"
    t.index ["character_id"], name: "index_inventories_on_character_id"
    t.index ["item_id"], name: "index_inventories_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "hp_bonus", default: 0, null: false
    t.string "name", null: false
    t.string "slot", null: false
    t.integer "strength_bonus", default: 0, null: false
    t.datetime "updated_at", null: false
    t.float "xp_multiplier", default: 1.0, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "character_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "npc_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["character_id"], name: "index_messages_on_character_id"
    t.index ["npc_id"], name: "index_messages_on_npc_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "npcs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "hp", default: 20, null: false
    t.string "name", null: false
    t.integer "step_id", null: false
    t.integer "strength", default: 5, null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_npcs_on_step_id"
  end

  create_table "quest_progresses", force: :cascade do |t|
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.integer "current_step_index", default: 0, null: false
    t.integer "quest_id", null: false
    t.string "status", default: "in_progress", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id", "quest_id"], name: "index_quest_progresses_on_character_id_and_quest_id", unique: true
    t.index ["character_id"], name: "index_quest_progresses_on_character_id"
    t.index ["quest_id"], name: "index_quest_progresses_on_quest_id"
  end

  create_table "quests", force: :cascade do |t|
    t.integer "completion_xp", default: 200, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "riddles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "question", null: false
    t.integer "step_id", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_riddles_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "experience_reward", default: 30, null: false
    t.integer "position", default: 1, null: false
    t.integer "quest_id", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id", "position"], name: "index_steps_on_quest_id_and_position"
    t.index ["quest_id"], name: "index_steps_on_quest_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "player", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "riddles"
  add_foreign_key "auction_listings", "characters", column: "buyer_id"
  add_foreign_key "auction_listings", "characters", column: "seller_id"
  add_foreign_key "auction_listings", "inventories"
  add_foreign_key "characters", "users"
  add_foreign_key "combat_sessions", "characters"
  add_foreign_key "combat_sessions", "npcs"
  add_foreign_key "inventories", "characters"
  add_foreign_key "inventories", "items"
  add_foreign_key "messages", "characters"
  add_foreign_key "messages", "npcs"
  add_foreign_key "messages", "users"
  add_foreign_key "npcs", "steps"
  add_foreign_key "quest_progresses", "characters"
  add_foreign_key "quest_progresses", "quests"
  add_foreign_key "riddles", "steps"
  add_foreign_key "steps", "quests"
end
