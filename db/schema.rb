# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161011000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "bills", force: :cascade do |t|
    t.date     "competence",                         null: false
    t.decimal  "water",      precision: 8, scale: 2
    t.decimal  "energy",     precision: 8, scale: 2
    t.decimal  "telephone",  precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "position"
    t.string   "email_address"
    t.string   "telephone"
    t.string   "celphone"
    t.string   "fax"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "maintainer_id", null: false
  end

  add_index "contacts", ["maintainer_id"], name: "index_contacts_on_maintainer_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.decimal  "value",         precision: 8, scale: 2, null: false
    t.date     "donation_date",                         null: false
    t.text     "remark"
    t.integer  "maintainer_id",                         null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "donations", ["maintainer_id"], name: "index_donations_on_maintainer_id", using: :btree

  create_table "email_histories", force: :cascade do |t|
    t.string   "body",                                     null: false
    t.decimal  "value",            precision: 8, scale: 2, null: false
    t.datetime "created_at",                               null: false
    t.string   "recipients_array",                         null: false
    t.integer  "send_type",                                null: false
    t.integer  "user_id",                                  null: false
    t.integer  "receipt_email_id",                         null: false
  end

  add_index "email_histories", ["receipt_email_id"], name: "index_email_histories_on_receipt_email_id", using: :btree
  add_index "email_histories", ["user_id"], name: "index_email_histories_on_user_id", using: :btree

  create_table "maintainers", force: :cascade do |t|
    t.string   "registration_name"
    t.string   "name",              null: false
    t.string   "cnpj"
    t.string   "cep"
    t.string   "address",           null: false
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state"
    t.string   "email_address"
    t.string   "website"
    t.text     "remark"
    t.integer  "category",          null: false
    t.integer  "group",             null: false
    t.integer  "contract"
    t.date     "first_parcel"
    t.integer  "payment_frequency"
    t.integer  "payment_period"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "cpf"
    t.integer  "entity_type"
  end

  create_table "product_and_service_data", force: :cascade do |t|
    t.date     "competence",             null: false
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_and_service_weeks", force: :cascade do |t|
    t.integer  "number",                       null: false
    t.date     "start_date",                   null: false
    t.date     "end_date",                     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "product_and_service_datum_id"
  end

  add_index "product_and_service_weeks", ["product_and_service_datum_id"], name: "index_product_and_service_weeks_on_product_and_service_datum_id", using: :btree

  create_table "product_data", force: :cascade do |t|
    t.integer  "mesh",                        null: false
    t.integer  "cream",                       null: false
    t.integer  "protector",                   null: false
    t.integer  "silicon",                     null: false
    t.integer  "mask",                        null: false
    t.integer  "foam",                        null: false
    t.integer  "skin_expander",               null: false
    t.integer  "cervical_collar",             null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "product_and_service_week_id"
  end

  add_index "product_data", ["product_and_service_week_id"], name: "index_product_data_on_product_and_service_week_id", using: :btree

  create_table "receipt_emails", force: :cascade do |t|
    t.string   "recipients_array",                                        null: false
    t.string   "body",                                                    null: false
    t.integer  "day_of_month",                                            null: false
    t.boolean  "active",                                   default: true, null: false
    t.decimal  "value",            precision: 8, scale: 2,                null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "maintainer_id",                                           null: false
  end

  add_index "receipt_emails", ["maintainer_id"], name: "index_receipt_emails_on_maintainer_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "description",                null: false
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "service_data", force: :cascade do |t|
    t.integer  "service_type",                null: false
    t.integer  "psychology",                  null: false
    t.integer  "physiotherapy",               null: false
    t.integer  "plastic_surgery",             null: false
    t.integer  "mesh",                        null: false
    t.integer  "gynecology",                  null: false
    t.integer  "occupational_therapy",        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "product_and_service_week_id"
  end

  add_index "service_data", ["product_and_service_week_id"], name: "index_service_data_on_product_and_service_week_id", using: :btree

  create_table "system_settings", force: :cascade do |t|
    t.string   "pse_recipients_array",                                          null: false
    t.string   "pse_title",                                                     null: false
    t.string   "pse_body",                                                      null: false
    t.string   "re_title",                                                      null: false
    t.string   "re_body",                                                       null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "user_id",                                                       null: false
    t.string   "pse_private_recipients_array", default: "exemplo@yahoo.com.br", null: false
  end

  add_index "system_settings", ["user_id"], name: "index_system_settings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                                  null: false
    t.boolean  "active",                 default: true, null: false
    t.text     "signature"
    t.string   "bcc"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "role_id",                               null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "contacts", "maintainers"
  add_foreign_key "donations", "maintainers"
  add_foreign_key "email_histories", "receipt_emails"
  add_foreign_key "email_histories", "users"
  add_foreign_key "product_and_service_weeks", "product_and_service_data"
  add_foreign_key "product_data", "product_and_service_weeks"
  add_foreign_key "receipt_emails", "maintainers"
  add_foreign_key "service_data", "product_and_service_weeks"
  add_foreign_key "system_settings", "users"
  add_foreign_key "users", "roles"
end
