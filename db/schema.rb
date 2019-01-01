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

ActiveRecord::Schema.define(version: 20181231132953) do

  create_table "account_versions", force: true do |t|
    t.integer  "member_id"
    t.integer  "account_id"
    t.integer  "reason"
    t.decimal  "balance",         precision: 32, scale: 16
    t.decimal  "locked",          precision: 32, scale: 16
    t.decimal  "fee",             precision: 32, scale: 16
    t.decimal  "amount",          precision: 32, scale: 16
    t.integer  "modifiable_id"
    t.string   "modifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency"
    t.integer  "fun"
  end

  add_index "account_versions", ["account_id", "reason"], name: "index_account_versions_on_account_id_and_reason", using: :btree
  add_index "account_versions", ["account_id"], name: "index_account_versions_on_account_id", using: :btree
  add_index "account_versions", ["member_id", "reason"], name: "index_account_versions_on_member_id_and_reason", using: :btree
  add_index "account_versions", ["modifiable_id", "modifiable_type"], name: "index_account_versions_on_modifiable_id_and_modifiable_type", using: :btree

  create_table "accounts", force: true do |t|
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "balance",                                    precision: 32, scale: 16
    t.decimal  "locked",                                     precision: 32, scale: 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "in",                                         precision: 32, scale: 16
    t.decimal  "out",                                        precision: 32, scale: 16
    t.integer  "default_withdraw_fund_source_id"
    t.string   "deposit_address",                 limit: 50
  end

  add_index "accounts", ["member_id", "currency"], name: "index_accounts_on_member_id_and_currency", using: :btree
  add_index "accounts", ["member_id"], name: "index_accounts_on_member_id", using: :btree

  create_table "api_tokens", force: true do |t|
    t.integer  "member_id",                        null: false
    t.string   "access_key",            limit: 50, null: false
    t.string   "secret_key",            limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trusted_ip_list"
    t.string   "label"
    t.integer  "oauth_access_token_id"
    t.datetime "expire_at"
    t.string   "scopes"
    t.datetime "deleted_at"
  end

  add_index "api_tokens", ["access_key"], name: "index_api_tokens_on_access_key", unique: true, using: :btree
  add_index "api_tokens", ["secret_key"], name: "index_api_tokens_on_secret_key", unique: true, using: :btree

  create_table "assets", force: true do |t|
    t.string  "type"
    t.integer "attachable_id"
    t.string  "attachable_type"
    t.string  "file"
  end

  create_table "audit_logs", force: true do |t|
    t.string   "type"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.string   "source_state"
    t.string   "target_state"
  end

  add_index "audit_logs", ["auditable_id", "auditable_type"], name: "index_audit_logs_on_auditable_id_and_auditable_type", using: :btree
  add_index "audit_logs", ["operator_id"], name: "index_audit_logs_on_operator_id", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  add_index "authentications", ["member_id"], name: "index_authentications_on_member_id", using: :btree
  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "banners", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogo_banners", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "target_link"
    t.string   "settings"
  end

  create_table "blogo_posts", force: true do |t|
    t.integer  "user_id",          null: false
    t.string   "permalink",        null: false
    t.string   "title",            null: false
    t.boolean  "published",        null: false
    t.datetime "published_at",     null: false
    t.string   "markup_lang",      null: false
    t.text     "raw_content",      null: false
    t.text     "html_content",     null: false
    t.text     "html_overview"
    t.string   "tags_string"
    t.string   "meta_description", null: false
    t.string   "meta_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogo_posts", ["permalink"], name: "index_blogo_posts_on_permalink", unique: true, using: :btree
  add_index "blogo_posts", ["published_at"], name: "index_blogo_posts_on_published_at", using: :btree
  add_index "blogo_posts", ["user_id"], name: "index_blogo_posts_on_user_id", using: :btree

  create_table "blogo_taggings", force: true do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "blogo_taggings", ["tag_id", "post_id"], name: "index_blogo_taggings_on_tag_id_and_post_id", unique: true, using: :btree

  create_table "blogo_tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogo_tags", ["name"], name: "index_blogo_tags_on_name", unique: true, using: :btree

  create_table "blogo_users", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogo_users", ["email"], name: "index_blogo_users_on_email", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "author_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticketrplyimage", limit: 300
    t.string   "ticketrplylink",  limit: 300
  end

  create_table "deposits", force: true do |t|
    t.integer  "account_id"
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "amount",                             precision: 32, scale: 16
    t.decimal  "fee",                                precision: 32, scale: 16
    t.string   "fund_uid"
    t.string   "fund_extra"
    t.string   "txid"
    t.integer  "state"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "done_at"
    t.string   "confirmations"
    t.string   "type"
    t.integer  "payment_transaction_id"
    t.integer  "txout"
    t.string   "fund_iban",              limit: 250
    t.string   "fund_code",              limit: 250
    t.string   "fund_account_name",      limit: 250
  end

  add_index "deposits", ["txid", "txout"], name: "index_deposits_on_txid_and_txout", using: :btree

  create_table "document_translations", force: true do |t|
    t.integer  "document_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.text     "desc"
    t.text     "keywords"
  end

  add_index "document_translations", ["document_id"], name: "index_document_translations_on_document_id", using: :btree
  add_index "document_translations", ["locale"], name: "index_document_translations_on_locale", using: :btree

  create_table "documents", force: true do |t|
    t.string   "key"
    t.string   "title"
    t.text     "body"
    t.boolean  "is_auth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "desc"
    t.text     "keywords"
  end

  create_table "entries", force: true do |t|
    t.string   "title"
    t.datetime "published"
    t.text     "content"
    t.string   "url"
    t.string   "author"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "escrows", force: true do |t|
    t.string   "tn_type"
    t.string   "tn_role"
    t.string   "tn_currency"
    t.decimal  "tn_amount",         precision: 10, scale: 0
    t.string   "item_name"
    t.string   "shipping_currency"
    t.decimal  "shipping_amount",   precision: 10, scale: 0
    t.string   "fee_payer"
    t.string   "inspection_length"
    t.text     "descriptions"
    t.integer  "member_id"
    t.integer  "recepient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "buyer_email"
    t.string   "seller_email"
    t.string   "amount_payer"
    t.string   "buyer_phone"
    t.string   "seller_phone"
    t.boolean  "agree_tc"
  end

  create_table "feeds", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_sources", force: true do |t|
    t.integer  "member_id"
    t.integer  "currency"
    t.string   "extra"
    t.string   "uid"
    t.boolean  "is_locked",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "iban",         limit: 250
    t.string   "account_name"
    t.string   "code",         limit: 250
    t.string   "country",      limit: 250
  end

  create_table "id_documents", force: true do |t|
    t.integer  "id_document_type"
    t.string   "name"
    t.string   "id_document_number"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birth_date"
    t.text     "address"
    t.string   "city"
    t.string   "country"
    t.string   "zipcode"
    t.integer  "id_bill_type"
    t.string   "aasm_state"
    t.string   "trader",             limit: 250
  end

  create_table "identities", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_active"
    t.integer  "retry_count"
    t.boolean  "is_locked"
    t.datetime "locked_at"
    t.datetime "last_verify_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_type",    limit: 250
  end

  create_table "likes", force: true do |t|
    t.integer  "total_likes"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "sn"
    t.string   "display_name"
    t.string   "email"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state"
    t.boolean  "activated"
    t.integer  "country_code"
    t.string   "phone_number"
    t.boolean  "disabled",                    default: false
    t.boolean  "api_disabled",                default: false
    t.string   "nickname"
    t.datetime "last_logged_at"
    t.string   "notes",           limit: 250
    t.text     "sendmail"
    t.text     "subject"
    t.text     "contents"
    t.string   "name"
    t.string   "sendmailcc",      limit: 250
    t.string   "dailyrate",       limit: 250
    t.string   "blockstatus",     limit: 5
    t.string   "username"
    t.string   "session_token"
    t.string   "password_digest"
  end

  create_table "meta_categories", force: true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "meta_contents", force: true do |t|
    t.string   "title"
    t.integer  "meta_category_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "money_exchanges", force: true do |t|
    t.integer  "sent_by_id"
    t.integer  "sent_to_id"
    t.string   "sent_on_email"
    t.integer  "status"
    t.text     "note"
    t.text     "declined_note"
    t.decimal  "amount",        precision: 10, scale: 0
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "request_type"
  end

  create_table "news", force: true do |t|
    t.string   "email",      null: false
    t.string   "summary"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.datetime "deleted_at"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.integer  "bid"
    t.integer  "ask"
    t.integer  "currency"
    t.decimal  "price",                     precision: 32, scale: 16
    t.decimal  "volume",                    precision: 32, scale: 16
    t.decimal  "origin_volume",             precision: 32, scale: 16
    t.integer  "state"
    t.datetime "done_at"
    t.string   "type",           limit: 8
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sn"
    t.string   "source",                                                            null: false
    t.string   "ord_type",       limit: 10
    t.decimal  "locked",                    precision: 32, scale: 16
    t.decimal  "origin_locked",             precision: 32, scale: 16
    t.decimal  "funds_received",            precision: 32, scale: 16, default: 0.0
    t.integer  "trades_count",                                        default: 0
  end

  add_index "orders", ["currency", "state"], name: "index_orders_on_currency_and_state", using: :btree
  add_index "orders", ["member_id", "state"], name: "index_orders_on_member_id_and_state", using: :btree
  add_index "orders", ["member_id"], name: "index_orders_on_member_id", using: :btree
  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree

  create_table "partial_trees", force: true do |t|
    t.integer  "proof_id",   null: false
    t.integer  "account_id", null: false
    t.text     "json",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sum"
  end

  create_table "payment_addresses", force: true do |t|
    t.integer  "account_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency"
  end

  create_table "payment_transactions", force: true do |t|
    t.string   "txid"
    t.decimal  "amount",                   precision: 32, scale: 16
    t.integer  "confirmations"
    t.string   "address"
    t.integer  "state"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "receive_at"
    t.datetime "dont_at"
    t.integer  "currency"
    t.string   "type",          limit: 60
    t.integer  "txout"
  end

  add_index "payment_transactions", ["txid", "txout"], name: "index_payment_transactions_on_txid_and_txout", using: :btree
  add_index "payment_transactions", ["type"], name: "index_payment_transactions_on_type", using: :btree

  create_table "pledges", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "reward_id"
    t.integer  "amount_pledged"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_categories", force: true do |t|
    t.integer  "category_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title",        null: false
    t.string   "blurb",        null: false
    t.string   "end_date",     null: false
    t.integer  "funding_goal", null: false
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "author"
    t.integer  "total_amount"
    t.text     "description"
  end

  create_table "proofs", force: true do |t|
    t.string   "root"
    t.integer  "currency"
    t.boolean  "ready",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sum"
    t.text     "addresses"
    t.string   "balance",    limit: 30
  end

  create_table "quick_exchanges", force: true do |t|
    t.string   "base_currency"
    t.string   "target_currency"
    t.integer  "member_id"
    t.decimal  "amount",          precision: 10, scale: 0
    t.integer  "status"
    t.text     "note"
    t.text     "admin_not"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.integer  "member_id",                null: false
    t.string   "readable_type", limit: 20, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["member_id"], name: "index_read_marks_on_member_id", using: :btree
  add_index "read_marks", ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id", using: :btree

  create_table "rewards", force: true do |t|
    t.string   "title"
    t.integer  "project_id"
    t.integer  "amount_met"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "running_accounts", force: true do |t|
    t.integer  "category"
    t.decimal  "income",      precision: 32, scale: 16, default: 0.0, null: false
    t.decimal  "expenses",    precision: 32, scale: 16, default: 0.0, null: false
    t.integer  "currency"
    t.integer  "member_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "running_accounts", ["member_id"], name: "index_running_accounts_on_member_id", using: :btree
  add_index "running_accounts", ["source_id", "source_type"], name: "index_running_accounts_on_source_id_and_source_type", using: :btree

  create_table "signup_histories", force: true do |t|
    t.integer  "member_id"
    t.string   "ip"
    t.string   "accept_language"
    t.string   "ua"
    t.datetime "created_at"
  end

  add_index "signup_histories", ["member_id"], name: "index_signup_histories_on_member_id", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "sliders", force: true do |t|
    t.text     "usdtxt"
    t.text     "poundtxt"
    t.text     "eurotxt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  create_table "sr_notofications", force: true do |t|
    t.integer  "member_id"
    t.text     "msg"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_page"
  end

  create_table "subscribers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "aasm_state"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticketimage", limit: 300
    t.string   "ticketlink",  limit: 300
  end

  create_table "tokens", force: true do |t|
    t.string   "token"
    t.datetime "expire_at"
    t.integer  "member_id"
    t.boolean  "is_used",    default: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokens", ["type", "token", "expire_at", "is_used"], name: "index_tokens_on_type_and_token_and_expire_at_and_is_used", using: :btree

  create_table "trades", force: true do |t|
    t.decimal  "price",         precision: 32, scale: 16
    t.decimal  "volume",        precision: 32, scale: 16
    t.integer  "ask_id"
    t.integer  "bid_id"
    t.integer  "trend"
    t.integer  "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ask_member_id"
    t.integer  "bid_member_id"
    t.decimal  "funds",         precision: 32, scale: 16
  end

  add_index "trades", ["ask_id"], name: "index_trades_on_ask_id", using: :btree
  add_index "trades", ["ask_member_id"], name: "index_trades_on_ask_member_id", using: :btree
  add_index "trades", ["bid_id"], name: "index_trades_on_bid_id", using: :btree
  add_index "trades", ["bid_member_id"], name: "index_trades_on_bid_member_id", using: :btree
  add_index "trades", ["created_at"], name: "index_trades_on_created_at", using: :btree
  add_index "trades", ["currency"], name: "index_trades_on_currency", using: :btree

  create_table "two_factors", force: true do |t|
    t.integer  "member_id"
    t.string   "otp_secret"
    t.datetime "last_verify_at"
    t.boolean  "activated"
    t.string   "type"
    t.datetime "refreshed_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "session_token"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visitor_counters", force: true do |t|
    t.string   "ip_address"
    t.boolean  "is_signedin"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "withdraws", force: true do |t|
    t.string   "sn"
    t.integer  "account_id"
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "amount",                        precision: 32, scale: 16
    t.decimal  "fee",                           precision: 32, scale: 16
    t.string   "fund_uid"
    t.string   "fund_extra"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "done_at"
    t.string   "txid"
    t.string   "aasm_state"
    t.decimal  "sum",                           precision: 32, scale: 16, default: 0.0, null: false
    t.string   "type"
    t.string   "fund_iban",         limit: 250
    t.string   "fund_code",         limit: 250
    t.string   "fund_account_name", limit: 250
  end

end
