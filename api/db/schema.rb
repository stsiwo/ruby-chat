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

ActiveRecord::Schema.define(version: 2021_10_05_082736) do

  create_table "chat_room_members", primary_key: ["user_id", "chat_room_id"], charset: "utf8mb4", force: :cascade do |t|
    t.timestamp "last_online_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "is_owner", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 11, null: false
    t.string "chat_room_id", limit: 11, null: false
    t.index ["chat_room_id"], name: "index_chat_room_members_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_members_on_user_id"
  end

  create_table "chat_rooms", id: :string, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "background_image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "owner_id", limit: 11, null: false
    t.index ["owner_id"], name: "index_chat_rooms_on_owner_id"
  end

  create_table "content_types", id: :string, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conversations", id: :string, charset: "utf8mb4", force: :cascade do |t|
    t.text "content", null: false
    t.string "background_image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 11, null: false
    t.string "chat_room_id", limit: 11, null: false
    t.string "content_type_id", limit: 11, null: false
    t.index ["chat_room_id"], name: "index_conversations_on_chat_room_id"
    t.index ["content_type_id"], name: "index_conversations_on_content_type_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "user_types", id: :string, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :string, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "password"
    t.string "avatar_image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type_id", limit: 11, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  add_foreign_key "chat_room_members", "chat_rooms", on_update: :cascade, on_delete: :cascade
  add_foreign_key "chat_room_members", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "chat_rooms", "users", column: "owner_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "conversations", "chat_rooms", on_update: :cascade, on_delete: :cascade
  add_foreign_key "conversations", "content_types", on_update: :cascade
  add_foreign_key "conversations", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "user_types", on_update: :cascade
end
