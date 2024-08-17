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

ActiveRecord::Schema[7.2].define(version: 2024_08_15_215516) do
  create_schema "auth"
  create_schema "extensions"
  create_schema "graphql"
  create_schema "graphql_public"
  create_schema "pgbouncer"
  create_schema "pgsodium"
  create_schema "pgsodium_masks"
  create_schema "realtime"
  create_schema "storage"
  create_schema "vault"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "pgsodium"
  enable_extension "plpgsql"
  enable_extension "supabase_vault"
  enable_extension "uuid-ossp"

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

  create_table "data_notes", force: :cascade do |t|
    t.string "series"
    t.string "invoice_number"
    t.datetime "emission_date"
    t.decimal "icms", precision: 10, scale: 2
    t.decimal "ipi", precision: 10, scale: 2
    t.decimal "pis", precision: 10, scale: 2
    t.decimal "cofins", precision: 10, scale: 2
    t.decimal "total_products", precision: 15, scale: 2
    t.decimal "total_taxes", precision: 15, scale: 2
    t.bigint "xml_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["xml_file_id"], name: "index_data_notes_on_xml_file_id"
  end

  create_table "issuers", force: :cascade do |t|
    t.string "cnpj"
    t.string "name"
    t.string "fantasy_name"
    t.string "address"
    t.string "number"
    t.string "neighborhood"
    t.string "municipality_code"
    t.string "municipality"
    t.string "state"
    t.string "zip_code"
    t.string "country_code"
    t.string "country"
    t.string "phone"
    t.string "state_registration"
    t.bigint "xml_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["xml_file_id"], name: "index_issuers_on_xml_file_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "ncm"
    t.string "cfop"
    t.string "unit"
    t.decimal "quantity", precision: 10, scale: 2
    t.decimal "unit_value", precision: 10, scale: 2
    t.bigint "xml_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["xml_file_id"], name: "index_products_on_xml_file_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "cnpj"
    t.string "name"
    t.string "fantasy_name"
    t.string "address"
    t.string "number"
    t.string "neighborhood"
    t.string "municipality_code"
    t.string "municipality"
    t.string "state"
    t.string "zip_code"
    t.string "country_code"
    t.string "country"
    t.bigint "xml_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["xml_file_id"], name: "index_recipients_on_xml_file_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "xml_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["xml_file_id"], name: "index_reports_on_xml_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "xml_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "data_notes", "xml_files"
  add_foreign_key "issuers", "xml_files"
  add_foreign_key "products", "xml_files"
  add_foreign_key "recipients", "xml_files"
  add_foreign_key "reports", "xml_files"
end
