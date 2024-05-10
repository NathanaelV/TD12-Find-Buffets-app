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

ActiveRecord::Schema[7.1].define(version: 20_240_508_081_241) do
  create_table 'buffets', force: :cascade do |t|
    t.string 'brand_name'
    t.string 'corporate_name'
    t.string 'registration_number'
    t.string 'phone'
    t.string 'email'
    t.string 'address'
    t.string 'string'
    t.string 'city'
    t.string 'state'
    t.string 'zip_code'
    t.string 'description'
    t.string 'payment'
    t.integer 'owner_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['owner_id'], name: 'index_buffets_on_owner_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name'
    t.string 'cpf'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_customers_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_customers_on_reset_password_token', unique: true
  end

  create_table 'event_costs', force: :cascade do |t|
    t.string 'description', null: false
    t.integer 'minimum', null: false
    t.integer 'additional_per_person'
    t.integer 'overtime'
    t.integer 'event_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_event_costs_on_event_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.integer 'min_people'
    t.integer 'max_people'
    t.integer 'duration'
    t.string 'menu'
    t.boolean 'alcoholic_beverages'
    t.boolean 'decoration'
    t.boolean 'parking'
    t.boolean 'parking_valet'
    t.boolean 'customer_space'
    t.integer 'buffet_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['buffet_id'], name: 'index_events_on_buffet_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'code'
    t.integer 'status', default: 0
    t.date 'event_date'
    t.integer 'people'
    t.string 'details'
    t.string 'address'
    t.integer 'buffet_id', null: false
    t.integer 'customer_id', null: false
    t.integer 'event_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['buffet_id'], name: 'index_orders_on_buffet_id'
    t.index ['customer_id'], name: 'index_orders_on_customer_id'
    t.index ['event_id'], name: 'index_orders_on_event_id'
  end

  create_table 'owners', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_owners_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_owners_on_reset_password_token', unique: true
  end

  create_table 'proposals', force: :cascade do |t|
    t.integer 'order_id', null: false
    t.integer 'event_id', null: false
    t.integer 'event_cost_id', null: false
    t.integer 'cost'
    t.date 'validate_date'
    t.integer 'price_change', default: 0
    t.string 'price_change_details'
    t.string 'payment'
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'customer_id', null: false
    t.index ['customer_id'], name: 'index_proposals_on_customer_id'
    t.index ['event_cost_id'], name: 'index_proposals_on_event_cost_id'
    t.index ['event_id'], name: 'index_proposals_on_event_id'
    t.index ['order_id'], name: 'index_proposals_on_order_id'
  end

  add_foreign_key 'buffets', 'owners'
  add_foreign_key 'event_costs', 'events'
  add_foreign_key 'events', 'buffets'
  add_foreign_key 'orders', 'buffets'
  add_foreign_key 'orders', 'customers'
  add_foreign_key 'orders', 'events'
  add_foreign_key 'proposals', 'customers'
  add_foreign_key 'proposals', 'event_costs'
  add_foreign_key 'proposals', 'events'
  add_foreign_key 'proposals', 'orders'
end
