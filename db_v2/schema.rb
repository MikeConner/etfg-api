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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analytics", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.decimal "risk_total_score", precision: 16, scale: 4
    t.decimal "risk_volatility", precision: 16, scale: 4
    t.decimal "risk_deviation", precision: 16, scale: 4
    t.decimal "risk_country", precision: 16, scale: 4
    t.decimal "risk_structure", precision: 16, scale: 4
    t.decimal "risk_liquidity", precision: 16, scale: 4
    t.decimal "risk_efficiency", precision: 16, scale: 4
    t.decimal "reward_score", precision: 16, scale: 4
    t.decimal "quant_total_score", precision: 16, scale: 4
    t.decimal "quant_technical_st", precision: 16, scale: 4
    t.decimal "quant_technical_it", precision: 16, scale: 4
    t.decimal "quant_technical_lt", precision: 16, scale: 4
    t.decimal "quant_composite_technical", precision: 16, scale: 4
    t.decimal "quant_sentiment_pc", precision: 16, scale: 4
    t.decimal "quant_sentiment_si", precision: 16, scale: 4
    t.decimal "quant_sentiment_iv", precision: 16, scale: 4
    t.decimal "quant_composite_sentiment", precision: 16, scale: 4
    t.decimal "quant_composite_behavioral", precision: 16, scale: 4
    t.decimal "quant_fundamental_pe", precision: 16, scale: 4
    t.decimal "quant_fundamental_pcf", precision: 16, scale: 4
    t.decimal "quant_fundamental_pb", precision: 16, scale: 4
    t.decimal "quant_fundamental_div", precision: 16, scale: 4
    t.decimal "quant_composite_fundamental", precision: 16, scale: 4
    t.decimal "quant_global_sector", precision: 16, scale: 4
    t.decimal "quant_global_country", precision: 16, scale: 4
    t.decimal "quant_composite_global", precision: 16, scale: 4
    t.decimal "quant_quality_liquidity", precision: 16, scale: 4
    t.decimal "quant_quality_diversification", precision: 16, scale: 4
    t.decimal "quant_quality_firm", precision: 16, scale: 4
    t.decimal "quant_composite_quality", precision: 16, scale: 4
    t.string "quant_grade", limit: 1
    t.index ["composite_ticker"], name: "index_analytics_on_composite_ticker_v2"
    t.index ["run_date", "composite_ticker"], name: "index_analytics_on_run_date_and_composite_ticker_v2", unique: true
    t.index ["run_date"], name: "index_analytics_on_run_date_v2"
  end

  create_table "constituents", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.text "composite_ticker"
    t.text "identifier"
    t.text "constituent_name"
    t.decimal "weight", precision: 24, scale: 12
    t.decimal "market_value"
    t.text "cusip"
    t.string "isin", limit: 16
    t.string "figi", limit: 16
    t.string "sedol", limit: 16
    t.string "country", limit: 32
    t.text "exchange"
    t.decimal "total_shares_held", precision: 18, scale: 4
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.string "currency", limit: 16
    t.index ["composite_ticker"], name: "index_constituents_on_composite_ticker_v2"
    t.index ["constituent_name"], name: "index_constituents_on_constituent_name_v2"
    t.index ["run_date"], name: "constituent_date_v2"
    t.index ["run_date"], name: "index_constituents_on_run_date_v2"
  end

  create_table "constituents_template", id: false, force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.text "composite_ticker"
    t.text "identifier"
    t.text "constituent_name"
    t.decimal "weight", precision: 24, scale: 12
    t.decimal "market_value"
    t.text "cusip"
    t.string "isin", limit: 16
    t.string "figi", limit: 16
    t.string "sedol", limit: 16
    t.string "country", limit: 32
    t.text "exchange"
    t.decimal "total_shares_held", precision: 18, scale: 4
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.bigint "api_instrument_id"
    t.bigint "api_pooled_instrument_id"
    t.string "currency", limit: 16
  end

  create_table "fund_flows", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.decimal "shares", precision: 14, scale: 2
    t.decimal "nav", precision: 14, scale: 6
    t.decimal "value", precision: 20, scale: 6
    t.index ["composite_ticker"], name: "index_fund_flows_on_composite_ticker_v2"
    t.index ["run_date", "composite_ticker"], name: "index_fund_flows_on_run_date_and_composite_ticker_v2", unique: true
    t.index ["run_date"], name: "index_fund_flows_on_run_date_v2"
  end

  create_table "industries", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.string "issuer", limit: 32
    t.string "name", limit: 128
    t.date "inception_date"
    t.string "related_index", limit: 128
    t.string "tax_classification", limit: 32
    t.boolean "is_etn"
    t.decimal "fund_aum", precision: 24, scale: 6
    t.string "avg_volume", limit: 10
    t.string "asset_class", limit: 32
    t.string "category", limit: 32
    t.string "focus", limit: 32
    t.string "development_level", limit: 32
    t.string "region", limit: 32
    t.boolean "is_leveraged"
    t.string "leverage_factor", limit: 16
    t.boolean "active"
    t.string "administrator", limit: 64
    t.string "advisor", limit: 64
    t.string "custodian", limit: 128
    t.string "distributor", limit: 128
    t.string "portfolio_manager"
    t.string "subadvisor", limit: 128
    t.string "transfer_agent", limit: 64
    t.string "trustee", limit: 64
    t.string "futures_commission_merchant", limit: 128
    t.string "fiscal_year_end", limit: 16
    t.string "distribution_frequency", limit: 1
    t.string "listing_exchange", limit: 64
    t.decimal "creation_unit_size", precision: 12
    t.decimal "creation_fee", precision: 8
    t.text "geographic_exposure"
    t.text "currency_exposure"
    t.text "sector_exposure"
    t.text "industry_group_exposure"
    t.text "industry_exposure"
    t.text "subindustry_exposure"
    t.text "coupon_exposure"
    t.text "maturity_exposure"
    t.boolean "option_available"
    t.string "option_volume", limit: 16
    t.decimal "short_interest", precision: 12
    t.string "put_call_ratio", limit: 32
    t.decimal "num_constituents", precision: 6
    t.decimal "discount_premium"
    t.decimal "bid_ask_spread", precision: 16, scale: 12
    t.string "put_vol"
    t.string "call_vol"
    t.decimal "management_fee", precision: 12, scale: 4
    t.decimal "other_expenses", precision: 12, scale: 4
    t.decimal "total_expenses", precision: 12, scale: 4
    t.decimal "fee_waivers", precision: 12, scale: 4
    t.decimal "net_expenses", precision: 12, scale: 4
    t.string "lead_market_maker", limit: 64
    t.index ["composite_ticker"], name: "index_industries_on_composite_ticker_v2"
    t.index ["run_date", "composite_ticker"], name: "index_industries_on_run_date_and_composite_ticker_v2", unique: true
    t.index ["run_date"], name: "index_industries_on_run_date_v2"
  end

end
