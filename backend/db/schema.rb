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

ActiveRecord::Schema[8.0].define(version: 2025_04_11_235958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "entry_exit", ["entry", "exit"]
  create_enum "marital_statuses", ["single", "married", "divorced", "widowed"]
  create_enum "operation_types", ["sale", "consignment", "return"]
  create_enum "payment_types", ["cash", "credit_card", "debit_card", "installment", "pix"]
  create_enum "person_types", ["individual", "company"]
  create_enum "statuses", ["active", "inactive", "deleted"]

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

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name", limit: 60, null: false
    t.integer "ibge", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
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

  create_table "states", force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.integer "ibge", null: false
    t.string "uf", limit: 2, null: false
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "people"
  add_foreign_key "cities", "states"
end
