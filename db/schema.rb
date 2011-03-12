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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110311190327) do

  create_table "branches_coupons", :id => false, :force => true do |t|
    t.integer "branch_id", :precision => 38, :scale => 0
    t.integer "coupon_id", :precision => 38, :scale => 0
  end

  create_table "branches_plans", :id => false, :force => true do |t|
    t.integer "branch_id", :precision => 38, :scale => 0
    t.integer "plan_id",   :precision => 38, :scale => 0
  end

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.integer  "amount",      :precision => 38, :scale => 0
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discount",    :precision => 38, :scale => 0
    t.datetime "start_date"
    t.datetime "expiry_date"
  end

  create_table "coupons_plans", :id => false, :force => true do |t|
    t.integer "coupon_id", :precision => 38, :scale => 0
    t.integer "plan_id",   :precision => 38, :scale => 0
  end

  create_table "events", :force => true do |t|
    t.string    "event_type"
    t.string    "val1"
    t.string    "val2"
    t.string    "val3"
    t.string    "val4"
    t.string    "val5"
    t.string    "val6"
    t.string    "val7"
    t.string    "val8"
    t.string    "val9"
    t.string    "val10"
    t.string    "val11"
    t.string    "val12"
    t.string    "val13"
    t.string    "val14"
    t.string    "val15"
    t.string    "val16"
    t.string    "val17"
    t.string    "val18"
    t.string    "val19"
    t.string    "val20"
    t.string    "val21"
    t.string    "val22"
    t.string    "val23"
    t.string    "val24"
    t.string    "val25"
    t.string    "val26"
    t.string    "val27"
    t.string    "val28"
    t.string    "val29"
    t.string    "val30"
    t.string    "val31"
    t.string    "val32"
    t.string    "val33"
    t.string    "val34"
    t.string    "val35"
    t.string    "val36"
    t.string    "val37"
    t.string    "val38"
    t.string    "val39"
    t.string    "val40"
    t.string    "val41"
    t.string    "val42"
    t.string    "val43"
    t.string    "val44"
    t.string    "val45"
    t.string    "val46"
    t.string    "val47"
    t.string    "val48"
    t.string    "val49"
    t.string    "val50"
    t.string    "val51"
    t.string    "val52"
    t.string    "val53"
    t.string    "val54"
    t.string    "val55"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
    t.integer   "version",                 :precision => 38, :scale => 0
    t.string    "status"
  end

  create_table "member_reversals", :force => true do |t|
    t.string    "membership_no"
    t.string    "nm_reversal"
    t.timestamp "created_at",    :limit => 6
    t.timestamp "updated_at",    :limit => 6
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.integer  "security_deposit",     :precision => 38, :scale => 0
    t.integer  "registration_fee",     :precision => 38, :scale => 0
    t.integer  "reading_fee",          :precision => 38, :scale => 0
    t.integer  "magazine_fee",         :precision => 38, :scale => 0
    t.integer  "num_books",            :precision => 38, :scale => 0
    t.integer  "num_magazines",        :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reading_limit",        :precision => 38, :scale => 0
    t.boolean  "subscription",         :precision => 1,  :scale => 0
    t.string   "frequency"
    t.string   "category"
    t.string   "home_delivery"
    t.string   "limit_basis"
    t.string   "restricted_to_branch"
    t.integer  "book_return_days",     :precision => 38, :scale => 0
    t.integer  "mandatory_months",     :precision => 38, :scale => 0
    t.string   "allow_renewal"
    t.datetime "expiry_date"
    t.datetime "start_date"
    t.integer  "rebate_category",      :precision => 38, :scale => 0
    t.string   "fast_moving_plans"
    t.string   "created_by"
    t.string   "modified_by"
  end

  create_table "rebates", :force => true do |t|
    t.integer  "category",          :precision => 38, :scale => 0
    t.integer  "membership_months", :precision => 38, :scale => 0
    t.integer  "rebate_months",     :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signups", :force => true do |t|
    t.string    "name",                                                                             :null => false
    t.string    "address",                                                                          :null => false
    t.integer   "mphone",                           :precision => 38, :scale => 0
    t.integer   "lphone",                           :precision => 38, :scale => 0
    t.string    "email",                                                                            :null => false
    t.string    "referrer_member_id"
    t.integer   "referrer_cust_id",                 :precision => 38, :scale => 0
    t.integer   "plan_id",                          :precision => 38, :scale => 0,                  :null => false
    t.integer   "branch_id",                        :precision => 38, :scale => 0
    t.integer   "signup_months",                    :precision => 38, :scale => 0,                  :null => false
    t.decimal   "security_deposit",                                                                 :null => false
    t.decimal   "registration_fee",                                                                 :null => false
    t.decimal   "reading_fee",                                                                      :null => false
    t.decimal   "discount",                                                                         :null => false
    t.decimal   "advance_amt",                                                                      :null => false
    t.decimal   "paid_amt",                                                                         :null => false
    t.decimal   "overdue_amt",                                                                      :null => false
    t.integer   "payment_mode",                     :precision => 38, :scale => 0,                  :null => false
    t.string    "payment_ref",                                                                      :null => false
    t.string    "membership_no"
    t.string    "application_no"
    t.string    "employee_no"
    t.integer   "created_by",                       :precision => 38, :scale => 0,                  :null => false
    t.integer   "modified_by",                      :precision => 38, :scale => 0,                  :null => false
    t.string    "flag_migrated",                                                   :default => "U"
    t.datetime  "start_date",                                                                       :null => false
    t.datetime  "expiry_date",                                                                      :null => false
    t.string    "remarks"
    t.timestamp "created_at",         :limit => 6
    t.timestamp "updated_at",         :limit => 6
    t.decimal   "coupon_amt"
    t.string    "coupon_no",          :limit => 20
    t.integer   "coupon_id",                        :precision => 38, :scale => 0
    t.string    "flag_reversed",                                                   :default => "N"
    t.integer   "company_id",                       :precision => 38, :scale => 0
  end

  add_index "signups", ["membership_no", "flag_reversed"], :name => "index1", :unique => true

end
