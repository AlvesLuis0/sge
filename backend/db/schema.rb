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

ActiveRecord::Schema[8.0].define(version: 2025_05_04_175842) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "contact_types", ["email", "mobile"]
  create_enum "entry_exit", ["entry", "exit"]
  create_enum "marital_statuses", ["single", "married", "divorced", "widowed"]
  create_enum "operation_types", ["sale", "consignment", "return"]
  create_enum "payment_types", ["cash", "credit_card", "debit_card", "installment", "pix"]
  create_enum "person_types", ["individual", "company"]
  create_enum "statuses", ["active", "inactive", "deleted"]

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

  create_table "addresses", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "street", limit: 60
    t.integer "number"
    t.string "complement", limit: 60
    t.string "zip_code", limit: 8
    t.string "neighborhood", limit: 60
    t.bigint "city_id"
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["person_id"], name: "index_addresses_on_person_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["status"], name: "index_categories_on_status"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name", limit: 60, null: false
    t.integer "ibge", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["status"], name: "index_colors_on_status"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.enum "contact_type", null: false, enum_type: "contact_types"
    t.string "email", limit: 100
    t.string "mobile_number", limit: 13
    t.index ["contact_type"], name: "index_contacts_on_contact_type"
    t.index ["person_id"], name: "index_contacts_on_person_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "registered_at", default: -> { "CURRENT_TIMESTAMP" }
    t.text "note"
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["person_id"], name: "index_customers_on_person_id"
    t.index ["status"], name: "index_customers_on_status"
  end

  create_table "operation_codes", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.enum "operation_type", null: false, enum_type: "operation_types"
    t.enum "entry_exit", null: false, enum_type: "entry_exit"
    t.boolean "updates_stock", null: false
    t.boolean "input_quantity_on_inclusion", null: false
    t.boolean "input_quantity_on_update", null: false
    t.boolean "input_price_on_inclusion", null: false
    t.boolean "input_price_on_update", null: false
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["entry_exit"], name: "index_operation_codes_on_entry_exit"
    t.index ["operation_type"], name: "index_operation_codes_on_operation_type"
    t.index ["status"], name: "index_operation_codes_on_status"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.enum "payment_type", null: false, enum_type: "payment_types"
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["payment_type"], name: "index_payment_methods_on_payment_type"
    t.index ["status"], name: "index_payment_methods_on_status"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.enum "person_type", null: false, enum_type: "person_types"
    t.string "cpf", limit: 11
    t.string "rg", limit: 15
    t.string "issuing_agency", limit: 20
    t.date "birth_date"
    t.enum "marital_status", enum_type: "marital_statuses"
    t.string "cnpj", limit: 14
    t.string "state_registration", limit: 20
    t.string "trade_name", limit: 40
    t.index ["cnpj"], name: "index_people_on_cnpj"
    t.index ["cpf"], name: "index_people_on_cpf"
    t.index ["marital_status"], name: "index_people_on_marital_status"
    t.index ["person_type"], name: "index_people_on_person_type"
  end

  create_table "sale_methods", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.integer "position"
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["status"], name: "index_sale_methods_on_status"
  end

  create_table "size_charts", force: :cascade do |t|
    t.string "description", limit: 60, null: false
    t.enum "status", default: "active", null: false, enum_type: "statuses"
    t.index ["status"], name: "index_size_charts_on_status"
  end

  create_table "sizes", force: :cascade do |t|
    t.bigint "size_chart_id", null: false
    t.string "description", limit: 4, null: false
    t.integer "position"
    t.index ["size_chart_id"], name: "index_sizes_on_size_chart_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.integer "ibge", null: false
    t.string "uf", limit: 2, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "people"
  add_foreign_key "cities", "states"
  add_foreign_key "contacts", "people"
  add_foreign_key "customers", "people"
  add_foreign_key "sizes", "size_charts"
end
