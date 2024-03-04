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

ActiveRecord::Schema[7.0].define(version: 2024_03_04_124224) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "banks", force: :cascade do |t|
    t.string "name", null: false
    t.string "number"
    t.string "email"
    t.string "phone"
    t.string "type"
    t.string "rif"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id", null: false
    t.bigint "corporation_id", null: false
    t.index ["corporation_id"], name: "index_banks_on_corporation_id"
    t.index ["currency_id"], name: "index_banks_on_currency_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "code", limit: 200, null: false
    t.string "client_type", default: "1", null: false
    t.string "name", limit: 200, null: false
    t.string "phone", limit: 200, null: false
    t.string "status", limit: 200, null: false
    t.string "notes", limit: 500
    t.string "address", limit: 500, null: false
    t.string "rif", limit: 200, null: false
    t.boolean "taxpayer"
    t.string "nit", limit: 200
    t.string "email", limit: 200
    t.integer "index"
    t.bigint "corporation_id", null: false
    t.bigint "user_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approval", default: false, null: false
    t.string "seller_code"
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
    t.bigint "default_currency_id"
    t.bigint "base_currency_id"
    t.string "db_driver"
    t.string "db_server"
    t.string "db_name"
    t.string "db_trusted"
    t.index ["base_currency_id"], name: "index_corporations_on_base_currency_id"
    t.index ["default_currency_id"], name: "index_corporations_on_default_currency_id"
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

  create_table "currencies", force: :cascade do |t|
    t.string "code", limit: 10, null: false
    t.string "description", limit: 50, null: false
    t.decimal "rate", precision: 10, scale: 4, null: false
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "code", limit: 50, null: false
    t.string "name", limit: 250, null: false
    t.string "model", limit: 50
    t.decimal "stock", precision: 10, scale: 2, default: "0.0", null: false
    t.string "unit", limit: 10, default: "UND", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "index"
    t.bigint "corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 20, default: "enabled", null: false
    t.string "supplier_code"
    t.index ["corporation_id", "code"], name: "index_items_on_corporation_id_and_code", unique: true
    t.index ["corporation_id"], name: "index_items_on_corporation_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "qty", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.bigint "order_id", null: false
    t.bigint "item_id", null: false
    t.bigint "currency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_order_details_on_currency_id"
    t.index ["item_id"], name: "index_order_details_on_item_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "order_histories", force: :cascade do |t|
    t.string "from", limit: 50, null: false
    t.string "to", limit: 50, null: false
    t.bigint "user_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_histories_on_order_id"
    t.index ["user_id"], name: "index_order_histories_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "sub_total", null: false
    t.decimal "taxes", null: false
    t.decimal "total", null: false
    t.decimal "rate", null: false
    t.string "status", default: "creado", null: false
    t.boolean "approved", default: false, null: false
    t.integer "index"
    t.decimal "balance", default: "0.0", null: false
    t.bigint "payment_condition_id"
    t.bigint "client_id", null: false
    t.bigint "currency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "corporation_id", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["corporation_id"], name: "index_orders_on_corporation_id"
    t.index ["currency_id"], name: "index_orders_on_currency_id"
    t.index ["payment_condition_id"], name: "index_orders_on_payment_condition_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_conditions", force: :cascade do |t|
    t.string "code", limit: 10, null: false
    t.string "description", limit: 50, null: false
    t.integer "days", null: false
    t.integer "index"
    t.bigint "corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporation_id"], name: "index_payment_conditions_on_corporation_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "status", default: "creado", null: false
    t.string "reference"
    t.bigint "bank_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_payments_on_bank_id"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "seller_type"
    t.string "rif"
    t.string "address"
    t.string "phones"
    t.string "commission"
    t.string "sale_commision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_sellers_on_code", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "inactive"
    t.string "zone"
    t.string "address"
    t.string "phones"
    t.string "supplier_type"
    t.string "rif"
    t.string "email"
    t.string "city"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.bigint "corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["corporation_id"], name: "index_units_on_corporation_id"
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
    t.bigint "current_corporation_id"
    t.index ["current_corporation_id"], name: "index_users_on_current_corporation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  create_table "warranties", force: :cascade do |t|
    t.decimal "quantity", precision: 10, scale: 2, default: "0.0", null: false
    t.string "notes", limit: 500
    t.string "status", limit: 50, null: false
    t.bigint "client_id", null: false
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.bigint "corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id", null: false
    t.bigint "seller_id", null: false
    t.text "notes2"
    t.index ["client_id"], name: "index_warranties_on_client_id"
    t.index ["corporation_id"], name: "index_warranties_on_corporation_id"
    t.index ["item_id"], name: "index_warranties_on_item_id"
    t.index ["seller_id"], name: "index_warranties_on_seller_id"
    t.index ["supplier_id"], name: "index_warranties_on_supplier_id"
    t.index ["user_id"], name: "index_warranties_on_user_id"
  end

  create_table "warranty_states", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "banks", "corporations"
  add_foreign_key "banks", "currencies"
  add_foreign_key "clients", "corporations"
  add_foreign_key "clients", "countries"
  add_foreign_key "clients", "users"
  add_foreign_key "corporations", "currencies", column: "base_currency_id"
  add_foreign_key "corporations", "currencies", column: "default_currency_id"
  add_foreign_key "items", "corporations"
  add_foreign_key "order_details", "currencies"
  add_foreign_key "order_details", "items"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_histories", "orders"
  add_foreign_key "order_histories", "users"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "corporations"
  add_foreign_key "orders", "currencies"
  add_foreign_key "orders", "payment_conditions"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_conditions", "corporations"
  add_foreign_key "payments", "banks"
  add_foreign_key "payments", "orders"
  add_foreign_key "units", "corporations"
  add_foreign_key "users", "corporations", column: "current_corporation_id"
  add_foreign_key "warranties", "clients"
  add_foreign_key "warranties", "corporations"
  add_foreign_key "warranties", "items"
  add_foreign_key "warranties", "sellers"
  add_foreign_key "warranties", "suppliers"
  add_foreign_key "warranties", "users"
end
