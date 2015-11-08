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

ActiveRecord::Schema.define(version: 20151117114331) do

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

  create_table "companies", force: :cascade do |t|
    t.string   "simple_name",             null: false
    t.string   "long_name",               null: false
    t.string   "cnpj",                    null: false
    t.string   "cep"
    t.string   "address",                 null: false
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state"
    t.string   "email_address"
    t.string   "website"
    t.integer  "category",                null: false
    t.integer  "group",                   null: false
    t.string   "donation"
    t.date     "first_parcel"
    t.date     "last_parcel"
    t.text     "remark"
    t.integer  "parcel_frequency"
    t.string   "total_period"
    t.string   "resp_name"
    t.string   "resp_cellphone"
    t.string   "resp_phone"
    t.string   "resp_fax"
    t.string   "resp_role"
    t.string   "resp_email_address"
    t.string   "assistant_name"
    t.string   "assistant_phone"
    t.string   "assistant_cellphone"
    t.string   "assistant_email_address"
    t.string   "financial_name"
    t.string   "financial_phone"
    t.string   "financial_cellphone"
    t.string   "financial_email_address"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "company_donations", force: :cascade do |t|
    t.decimal  "value",         precision: 8, scale: 2, null: false
    t.date     "donation_date",                         null: false
    t.text     "remark"
    t.integer  "user_id",                               null: false
    t.integer  "company_id",                            null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "company_donations", ["company_id"], name: "index_company_donations_on_company_id", using: :btree
  add_index "company_donations", ["user_id"], name: "index_company_donations_on_user_id", using: :btree

  create_table "email_configurations", force: :cascade do |t|
    t.text     "signature",      null: false
    t.string   "test_recipient"
    t.string   "bcc"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "email_histories", force: :cascade do |t|
    t.string   "body",                                     null: false
    t.decimal  "value",            precision: 8, scale: 2, null: false
    t.datetime "created_at",                               null: false
    t.string   "recipients_array",                         null: false
    t.integer  "send_type",                                null: false
    t.integer  "user_id",                                  null: false
    t.integer  "email_id",                                 null: false
  end

  add_index "email_histories", ["email_id"], name: "index_email_histories_on_email_id", using: :btree
  add_index "email_histories", ["user_id"], name: "index_email_histories_on_user_id", using: :btree

  create_table "email_types", force: :cascade do |t|
    t.string   "name"
    t.string   "email_title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "email_id",    null: false
  end

  add_index "email_types", ["email_id"], name: "index_email_types_on_email_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.string   "recipients_array",                                              null: false
    t.string   "body",                                                          null: false
    t.integer  "day_of_month",                                                  null: false
    t.boolean  "active",                                         default: true, null: false
    t.decimal  "value",                  precision: 8, scale: 2,                null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "email_configuration_id",                                        null: false
    t.integer  "company_id",                                                    null: false
  end

  add_index "emails", ["company_id"], name: "index_emails_on_company_id", using: :btree
  add_index "emails", ["email_configuration_id"], name: "index_emails_on_email_configuration_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "description",                null: false
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

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
    t.string   "test_recipient"
    t.string   "bcc"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "role_id",                               null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "company_donations", "companies"
  add_foreign_key "company_donations", "users"
  add_foreign_key "email_histories", "emails"
  add_foreign_key "email_histories", "users"
  add_foreign_key "email_types", "emails"
  add_foreign_key "emails", "companies"
  add_foreign_key "emails", "email_configurations"
  add_foreign_key "users", "roles"
end
