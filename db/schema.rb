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

ActiveRecord::Schema[7.0].define(version: 2023_06_20_115300) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "code", limit: 50, null: false
    t.integer "type", default: 1, null: false
    t.string "name", limit: 50, null: false
    t.string "phone", limit: 50, null: false
    t.string "status", limit: 50, null: false
    t.string "notes", limit: 500
    t.string "address", limit: 500, null: false
    t.string "rif", limit: 15, null: false
    t.boolean "taxpayer"
    t.string "nit", limit: 15
    t.string "email", limit: 50
    t.integer "index"
    t.bigint "corporation_id", null: false
    t.bigint "user_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporation_id"], name: "index_clients_on_corporation_id"
    t.index ["country_id"], name: "index_clients_on_country_id"
    t.index ["rif"], name: "index_clients_on_rif", unique: true
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "corporations", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "rif", limit: 15, null: false
    t.string "address", limit: 100, null: false
    t.string "phone", limit: 15
    t.string "email", limit: 50
    t.string "website", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 20, default: "enabled", null: false
    t.index ["name"], name: "index_corporations_on_name", unique: true
    t.index ["rif"], name: "index_corporations_on_rif", unique: true
  end

  create_table "corporations_users", id: false, force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "user_id"
    t.index ["corporation_id"], name: "index_corporations_users_on_corporation_id"
    t.index ["user_id"], name: "index_corporations_users_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "code", limit: 50, null: false
    t.string "name", limit: 50, null: false
    t.string "model", limit: 50
    t.decimal "stock", precision: 10, scale: 2, default: "0.0", null: false
    t.string "unit", limit: 10, default: "UND", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "index"
    t.bigint "corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 20, default: "enabled", null: false
    t.index ["corporation_id", "code"], name: "index_items_on_corporation_id_and_code", unique: true
    t.index ["corporation_id"], name: "index_items_on_corporation_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "user_name", limit: 50, null: false
    t.string "email", limit: 50, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 20, default: "disabled", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "clients", "corporations"
  add_foreign_key "clients", "countries"
  add_foreign_key "clients", "users"
  add_foreign_key "items", "corporations"
end
