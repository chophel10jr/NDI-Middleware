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

ActiveRecord::Schema[7.1].define(version: 2024_08_05_055100) do
  create_table "foundational_ids", force: :cascade do |t|
    t.string "full_name"
    t.string "gender"
    t.date "date_of_birth"
    t.string "id_type"
    t.string "id_number"
    t.string "citizenship"
    t.string "household_number"
    t.string "blood_type"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_foundational_ids_on_user_id"
  end

  create_table "ndi_webhook_records", force: :cascade do |t|
    t.boolean "executed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permanent_addresses", force: :cascade do |t|
    t.string "house_number"
    t.string "thram_number"
    t.string "village"
    t.string "gewog"
    t.string "dzongkhag"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_permanent_addresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "foundational_ids", "users"
  add_foreign_key "permanent_addresses", "users"
end
