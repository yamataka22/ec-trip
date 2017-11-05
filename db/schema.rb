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

ActiveRecord::Schema.define(version: 20171103060847) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id",                     null: false
    t.boolean  "invoice",       default: false, null: false
    t.boolean  "delivery",      default: true,  null: false
    t.string   "last_name",                     null: false
    t.string   "first_name",                    null: false
    t.string   "postal_code",                   null: false
    t.integer  "prefecture_id",                 null: false
    t.string   "address1",                      null: false
    t.string   "address2"
    t.string   "phone",                         null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["member_id"], name: "index_addresses_on_member_id", using: :btree
  end

  create_table "bounce_mails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.string   "session_id"
    t.integer  "item_id",                null: false
    t.integer  "quantity",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["item_id"], name: "index_carts_on_item_id", using: :btree
    t.index ["member_id"], name: "index_carts_on_member_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                         null: false
    t.integer  "root_category_id"
    t.integer  "sequence",         default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "category_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_category_items_on_category_id", using: :btree
    t.index ["item_id"], name: "index_category_items_on_item_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535,                 null: false
    t.string   "email",                                    null: false
    t.string   "last_name",                                null: false
    t.string   "first_name"
    t.string   "phone"
    t.boolean  "read",                     default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "credit_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id",                      null: false
    t.string   "stripe_card_id",                 null: false
    t.string   "brand",                          null: false
    t.string   "last4",                          null: false
    t.string   "exp_month",                      null: false
    t.string   "exp_year",                       null: false
    t.string   "name",                           null: false
    t.boolean  "main",           default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["member_id"], name: "index_credit_cards_on_member_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "developer_mails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id",  null: false
    t.integer  "item_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_favorites_on_item_id", using: :btree
    t.index ["member_id"], name: "index_favorites_on_member_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                           null: false
    t.string   "description"
    t.integer  "caption_image_id"
    t.text     "about",            limit: 65535
    t.integer  "price"
    t.integer  "stock_quantity"
    t.string   "remarks"
    t.integer  "status",                         default: 0,     null: false
    t.boolean  "pickup",                                         null: false
    t.boolean  "arrival_new",                    default: false, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["caption_image_id"], name: "fk_rails_812ccc6369", using: :btree
  end

  create_table "managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "last_name",                              null: false
    t.string   "first_name",                             null: false
    t.boolean  "mail_accept",            default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_managers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "account_name",                        null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "profile_image_id"
    t.string   "stripe_customer_id"
    t.integer  "main_address_id"
    t.integer  "main_credit_card_id"
    t.string   "leave_at"
    t.string   "leave_reason"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_members_on_email", unique: true, using: :btree
    t.index ["provider", "uid"], name: "index_members_on_provider_and_uid", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree
    t.index ["stripe_customer_id"], name: "index_members_on_stripe_customer_id", unique: true, using: :btree
  end

  create_table "previews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "purchase_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "purchase_id", null: false
    t.integer  "item_id",     null: false
    t.string   "item_name",   null: false
    t.integer  "price",       null: false
    t.integer  "quantity",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_id"], name: "index_purchase_details_on_item_id", using: :btree
    t.index ["purchase_id"], name: "index_purchase_details_on_purchase_id", using: :btree
  end

  create_table "purchases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.integer  "item_amount",                          default: 0,     null: false
    t.integer  "tax",                                                  null: false
    t.integer  "delivery_fee",                                         null: false
    t.string   "delivery_last_name",                                   null: false
    t.string   "delivery_first_name",                                  null: false
    t.string   "delivery_phone",                                       null: false
    t.string   "delivery_postal_code",                                 null: false
    t.integer  "delivery_prefecture_id",                               null: false
    t.string   "delivery_address1",                                    null: false
    t.string   "delivery_address2"
    t.string   "invoice_last_name",                                    null: false
    t.string   "invoice_first_name",                                   null: false
    t.string   "invoice_phone",                                        null: false
    t.string   "invoice_postal_code",                                  null: false
    t.integer  "invoice_prefecture_id",                                null: false
    t.string   "invoice_address1",                                     null: false
    t.string   "invoice_address2"
    t.string   "guest_email"
    t.string   "cart_session_id"
    t.string   "stripe_charge_id",                                     null: false
    t.date     "purchased_date",                                       null: false
    t.text     "remarks",                limit: 65535
    t.boolean  "delivered",                            default: false, null: false
    t.datetime "delivered_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["member_id"], name: "index_purchases_on_member_id", using: :btree
  end

  create_table "sliders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "description"
    t.text     "link_url",         limit: 65535
    t.integer  "image_id"
    t.integer  "caption_position",               default: 0, null: false
    t.integer  "caption_color",                  default: 0, null: false
    t.boolean  "published"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["image_id"], name: "index_sliders_on_image_id", using: :btree
  end

  create_table "static_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                     null: false
    t.string   "title",                                    null: false
    t.text     "content",    limit: 65535,                 null: false
    t.boolean  "published",                default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["name"], name: "index_static_pages_on_name", unique: true, using: :btree
  end

  create_table "taxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rate"
    t.date     "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",      null: false
    t.string   "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "members"
  add_foreign_key "carts", "items"
  add_foreign_key "carts", "members"
  add_foreign_key "category_items", "categories"
  add_foreign_key "category_items", "items"
  add_foreign_key "credit_cards", "members"
  add_foreign_key "favorites", "items"
  add_foreign_key "favorites", "members"
  add_foreign_key "items", "images", column: "caption_image_id"
  add_foreign_key "purchase_details", "items"
  add_foreign_key "purchase_details", "purchases"
  add_foreign_key "purchases", "members"
  add_foreign_key "sliders", "images"
end
