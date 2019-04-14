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

ActiveRecord::Schema.define(version: 2019_04_13_054957) do

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

  create_table "analytics_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "composite_ticker"
    t.text "risk_total_score"
    t.text "risk_volatility"
    t.text "risk_deviation"
    t.text "risk_country"
    t.text "risk_structure"
    t.text "risk_liquidity"
    t.text "risk_efficiency"
    t.text "reward_score"
    t.text "quant_total_score"
    t.text "quant_technical_st"
    t.text "quant_technical_it"
    t.text "quant_technical_lt"
    t.text "quant_composite_technical"
    t.text "quant_sentiment_pc"
    t.text "quant_sentiment_si"
    t.text "quant_sentiment_iv"
    t.text "quant_composite_sentiment"
    t.text "quant_composite_behavioral"
    t.text "quant_fundamental_pe"
    t.text "quant_fundamental_pcf"
    t.text "quant_fundamental_pb"
    t.text "quant_fundamental_div"
    t.text "quant_composite_fundamental"
    t.text "quant_global_sector"
    t.text "quant_global_country"
    t.text "quant_composite_global"
    t.text "quant_quality_liquidity"
    t.text "quant_quality_diversification"
    t.text "quant_quality_firm"
    t.text "quant_composite_quality"
    t.text "quant_grade"
  end

  create_table "constituents", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.string "identifier", limit: 64
    t.string "constituent_name"
    t.decimal "weight", precision: 18, scale: 10
    t.decimal "market_value", precision: 22, scale: 6
    t.string "cusip", limit: 24
    t.string "isin", limit: 16
    t.string "figi", limit: 16
    t.string "sedol", limit: 16
    t.string "country", limit: 32
    t.string "exchange", limit: 64
    t.decimal "total_shares_held", precision: 22, scale: 6
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.string "currency", limit: 16
    t.string "region", limit: 2
    t.string "base_currency", limit: 16
    t.index ["composite_ticker"], name: "index_constituents_on_composite_ticker"
    t.index ["constituent_name"], name: "index_constituents_on_constituent_name"
    t.index ["run_date"], name: "index_constituents_on_run_date"
  end

  create_table "constituents_template", id: false, force: :cascade do |t|
    t.date "run_date"
    t.date "as_of_date"
    t.string "composite_ticker", limit: 32
    t.string "identifier", limit: 64
    t.string "constituent_name", limit: 255
    t.decimal "weight", precision: 18, scale: 10
    t.decimal "market_value", precision: 22, scale: 6
    t.string "cusip", limit: 9
    t.string "isin", limit: 12
    t.string "figi", limit: 12
    t.string "sedol", limit: 7
    t.string "country", limit: 64
    t.string "exchange", limit: 64
    t.decimal "total_shares_held", precision: 22, scale: 6
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.bigint "api_instrument_id"
    t.bigint "api_pooled_instrument_id"
    t.string "currency", limit: 16
    t.string "region", limit: 2
    t.string "base_currency", limit: 16
  end

  create_table "esg_core_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "company_name"
    t.text "isin"
    t.text "region"
    t.text "sector"
    t.text "industry"
    t.text "e1"
    t.text "e2"
    t.text "e3"
    t.text "emp1"
    t.text "emp2"
    t.text "emp3"
    t.text "cit1"
    t.text "cit2"
    t.text "cit3"
    t.text "g1"
    t.text "g2"
    t.text "g3"
    t.text "e"
    t.text "s"
    t.text "g"
    t.text "esg"
    t.text "carbon"
    t.text "diversity"
    t.text "controversy"
    t.text "percentile_sector_e1"
    t.text "percentile_sector_e2"
    t.text "percentile_sector_e3"
    t.text "percentile_sector_emp1"
    t.text "percentile_sector_emp2"
    t.text "percentile_sector_emp3"
    t.text "percentile_sector_cit1"
    t.text "percentile_sector_cit2"
    t.text "percentile_sector_cit3"
    t.text "percentile_sector_g1"
    t.text "percentile_sector_g2"
    t.text "percentile_sector_g3"
    t.text "percentile_sector_e"
    t.text "percentile_sector_s"
    t.text "percentile_sector_g"
    t.text "percentile_sector_esg"
    t.text "percentile_sector_carbon"
    t.text "percentile_sector_diversity"
    t.text "percentile_sector_controversy"
    t.text "percentile_us_lg_cap_sector_e1"
    t.text "percentile_us_lg_cap_sector_e2"
    t.text "percentile_us_lg_cap_sector_e3"
    t.text "percentile_us_lg_cap_sector_emp1"
    t.text "percentile_us_lg_cap_sector_emp2"
    t.text "percentile_us_lg_cap_sector_emp3"
    t.text "percentile_us_lg_cap_sector_cit1"
    t.text "percentile_us_lg_cap_sector_cit2"
    t.text "percentile_us_lg_cap_sector_cit3"
    t.text "percentile_us_lg_cap_sector_g1"
    t.text "percentile_us_lg_cap_sector_g2"
    t.text "percentile_us_lg_cap_sector_g3"
    t.text "percentile_us_lg_cap_sector_e"
    t.text "percentile_us_lg_cap_sector_s"
    t.text "percentile_us_lg_cap_sector_g"
    t.text "percentile_us_lg_cap_sector_esg"
    t.text "percentile_us_lg_cap_sector_carbon"
    t.text "percentile_us_lg_cap_sector_diversity"
    t.text "percentile_us_lg_cap_sector_controversy"
    t.text "percentile_us_sm_cap_sector_e1"
    t.text "percentile_us_sm_cap_sector_e2"
    t.text "percentile_us_sm_cap_sector_e3"
    t.text "percentile_us_sm_cap_sector_emp1"
    t.text "percentile_us_sm_cap_sector_emp2"
    t.text "percentile_us_sm_cap_sector_emp3"
    t.text "percentile_us_sm_cap_sector_cit1"
    t.text "percentile_us_sm_cap_sector_cit2"
    t.text "percentile_us_sm_cap_sector_cit3"
    t.text "percentile_us_sm_cap_sector_g1"
    t.text "percentile_us_sm_cap_sector_g2"
    t.text "percentile_us_sm_cap_sector_g3"
    t.text "percentile_us_sm_cap_sector_e"
    t.text "percentile_us_sm_cap_sector_s"
    t.text "percentile_us_sm_cap_sector_g"
    t.text "percentile_us_sm_cap_sector_esg"
    t.text "percentile_us_sm_cap_sector_carbon"
    t.text "percentile_us_sm_cap_sector_diversity"
    t.text "percentile_us_sm_cap_sector_controversy"
    t.text "percentile_us_e1"
    t.text "percentile_us_e2"
    t.text "percentile_us_e3"
    t.text "percentile_us_emp1"
    t.text "percentile_us_emp2"
    t.text "percentile_us_emp3"
    t.text "percentile_us_cit1"
    t.text "percentile_us_cit2"
    t.text "percentile_us_cit3"
    t.text "percentile_us_g1"
    t.text "percentile_us_g2"
    t.text "percentile_us_g3"
    t.text "percentile_us_e"
    t.text "percentile_us_s"
    t.text "percentile_us_g"
    t.text "percentile_us_esg"
    t.text "percentile_us_carbon"
    t.text "percentile_us_diversity"
    t.text "percentile_us_controversy"
    t.text "quantile_us_e1"
    t.text "quantile_us_e2"
    t.text "quantile_us_e3"
    t.text "quantile_us_emp1"
    t.text "quantile_us_emp2"
    t.text "quantile_us_emp3"
    t.text "quantile_us_cit1"
    t.text "quantile_us_cit2"
    t.text "quantile_us_cit3"
    t.text "quantile_us_g1"
    t.text "quantile_us_g2"
    t.text "quantile_us_g3"
    t.text "quantile_us_e"
    t.text "quantile_us_s"
    t.text "quantile_us_g"
    t.text "quantile_us_esg"
    t.text "quantile_us_carbon"
    t.text "quantile_us_diversity"
    t.text "quantile_us_controversy"
    t.text "percentile_us_lg_cap_e1"
    t.text "percentile_us_lg_cap_e2"
    t.text "percentile_us_lg_cap_e3"
    t.text "percentile_us_lg_cap_emp1"
    t.text "percentile_us_lg_cap_emp2"
    t.text "percentile_us_lg_cap_emp3"
    t.text "percentile_us_lg_cap_cit1"
    t.text "percentile_us_lg_cap_cit2"
    t.text "percentile_us_lg_cap_cit3"
    t.text "percentile_us_lg_cap_g1"
    t.text "percentile_us_lg_cap_g2"
    t.text "percentile_us_lg_cap_g3"
    t.text "percentile_us_lg_cap_e"
    t.text "percentile_us_lg_cap_s"
    t.text "percentile_us_lg_cap_g"
    t.text "percentile_us_lg_cap_esg"
    t.text "percentile_us_lg_cap_carbon"
    t.text "percentile_us_lg_cap_diversity"
    t.text "percentile_us_lg_cap_controversy"
    t.text "quantile_us_lg_cap_e1"
    t.text "quantile_us_lg_cap_e2"
    t.text "quantile_us_lg_cap_e3"
    t.text "quantile_us_lg_cap_emp1"
    t.text "quantile_us_lg_cap_emp2"
    t.text "quantile_us_lg_cap_emp3"
    t.text "quantile_us_lg_cap_cit1"
    t.text "quantile_us_lg_cap_cit2"
    t.text "quantile_us_lg_cap_cit3"
    t.text "quantile_us_lg_cap_g1"
    t.text "quantile_us_lg_cap_g2"
    t.text "quantile_us_lg_cap_g3"
    t.text "quantile_us_lg_cap_e"
    t.text "quantile_us_lg_cap_s"
    t.text "quantile_us_lg_cap_g"
    t.text "quantile_us_lg_cap_esg"
    t.text "quantile_us_lg_cap_carbon"
    t.text "quantile_us_lg_cap_diversity"
    t.text "quantile_us_lg_cap_controversy"
    t.text "percentile_us_sm_cap_e1"
    t.text "percentile_us_sm_cap_e2"
    t.text "percentile_us_sm_cap_e3"
    t.text "percentile_us_sm_cap_emp1"
    t.text "percentile_us_sm_cap_emp2"
    t.text "percentile_us_sm_cap_emp3"
    t.text "percentile_us_sm_cap_cit1"
    t.text "percentile_us_sm_cap_cit2"
    t.text "percentile_us_sm_cap_cit3"
    t.text "percentile_us_sm_cap_g1"
    t.text "percentile_us_sm_cap_g2"
    t.text "percentile_us_sm_cap_g3"
    t.text "percentile_us_sm_cap_e"
    t.text "percentile_us_sm_cap_s"
    t.text "percentile_us_sm_cap_g"
    t.text "percentile_us_sm_cap_esg"
    t.text "percentile_us_sm_cap_carbon"
    t.text "percentile_us_sm_cap_diversity"
    t.text "percentile_us_sm_cap_controversy"
    t.text "quantile_us_sm_cap_e1"
    t.text "quantile_us_sm_cap_e2"
    t.text "quantile_us_sm_cap_e3"
    t.text "quantile_us_sm_cap_emp1"
    t.text "quantile_us_sm_cap_emp2"
    t.text "quantile_us_sm_cap_emp3"
    t.text "quantile_us_sm_cap_cit1"
    t.text "quantile_us_sm_cap_cit2"
    t.text "quantile_us_sm_cap_cit3"
    t.text "quantile_us_sm_cap_g1"
    t.text "quantile_us_sm_cap_g2"
    t.text "quantile_us_sm_cap_g3"
    t.text "quantile_us_sm_cap_e"
    t.text "quantile_us_sm_cap_s"
    t.text "quantile_us_sm_cap_g"
    t.text "quantile_us_sm_cap_esg"
    t.text "quantile_us_sm_cap_carbon"
    t.text "quantile_us_sm_cap_diversity"
    t.text "quantile_us_sm_cap_controversy"
    t.text "forecast_impact_e1"
    t.text "forecast_impact_e2"
    t.text "forecast_impact_e3"
    t.text "forecast_impact_emp1"
    t.text "forecast_impact_emp2"
    t.text "forecast_impact_emp3"
    t.text "forecast_impact_cit1"
    t.text "forecast_impact_cit2"
    t.text "forecast_impact_cit3"
    t.text "forecast_impact_g1"
    t.text "forecast_impact_g2"
    t.text "forecast_impact_g3"
    t.text "forecast_impact_e"
    t.text "forecast_impact_s"
    t.text "forecast_impact_g"
    t.text "forecast_impact_esg"
    t.text "forecast_impact_carbon"
    t.text "forecast_impact_diversity"
    t.text "forecast_impact_controversy"
    t.text "historic_model_ex_market"
    t.text "historic_model_ex_market_sector"
    t.text "dynamic_model_ex_market"
    t.text "dynamic_model_ex_market_sector"
  end

  create_table "esg_cores", force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "company_name"
    t.string "isin", limit: 12
    t.string "region"
    t.string "sector"
    t.string "industry"
    t.decimal "e1", precision: 22, scale: 6
    t.decimal "e2", precision: 22, scale: 6
    t.decimal "e3", precision: 22, scale: 6
    t.decimal "emp1", precision: 22, scale: 6
    t.decimal "emp2", precision: 22, scale: 6
    t.decimal "emp3", precision: 22, scale: 6
    t.decimal "cit1", precision: 22, scale: 6
    t.decimal "cit2", precision: 22, scale: 6
    t.decimal "cit3", precision: 22, scale: 6
    t.decimal "g1", precision: 22, scale: 6
    t.decimal "g2", precision: 22, scale: 6
    t.decimal "g3", precision: 22, scale: 6
    t.decimal "e", precision: 22, scale: 6
    t.decimal "s", precision: 22, scale: 6
    t.decimal "g", precision: 22, scale: 6
    t.decimal "esg", precision: 22, scale: 6
    t.decimal "carbon", precision: 22, scale: 6
    t.decimal "diversity", precision: 22, scale: 6
    t.decimal "controversy", precision: 22, scale: 6
    t.decimal "percentile_sector_e1", precision: 22, scale: 6
    t.decimal "percentile_sector_e2", precision: 22, scale: 6
    t.decimal "percentile_sector_e3", precision: 22, scale: 6
    t.decimal "percentile_sector_emp1", precision: 22, scale: 6
    t.decimal "percentile_sector_emp2", precision: 22, scale: 6
    t.decimal "percentile_sector_emp3", precision: 22, scale: 6
    t.decimal "percentile_sector_cit1", precision: 22, scale: 6
    t.decimal "percentile_sector_cit2", precision: 22, scale: 6
    t.decimal "percentile_sector_cit3", precision: 22, scale: 6
    t.decimal "percentile_sector_g1", precision: 22, scale: 6
    t.decimal "percentile_sector_g2", precision: 22, scale: 6
    t.decimal "percentile_sector_g3", precision: 22, scale: 6
    t.decimal "percentile_sector_e", precision: 22, scale: 6
    t.decimal "percentile_sector_s", precision: 22, scale: 6
    t.decimal "percentile_sector_g", precision: 22, scale: 6
    t.decimal "percentile_sector_esg", precision: 22, scale: 6
    t.decimal "percentile_sector_carbon", precision: 22, scale: 6
    t.decimal "percentile_sector_diversity", precision: 22, scale: 6
    t.decimal "percentile_sector_controversy", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_e1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_e2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_e3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_g1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_g2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_g3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_e", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_s", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_g", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_esg", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_sector_controversy", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_e1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_e2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_e3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_g1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_g2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_g3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_e", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_s", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_g", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_esg", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_sector_controversy", precision: 22, scale: 6
    t.decimal "percentile_us_e1", precision: 22, scale: 6
    t.decimal "percentile_us_e2", precision: 22, scale: 6
    t.decimal "percentile_us_e3", precision: 22, scale: 6
    t.decimal "percentile_us_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_g1", precision: 22, scale: 6
    t.decimal "percentile_us_g2", precision: 22, scale: 6
    t.decimal "percentile_us_g3", precision: 22, scale: 6
    t.decimal "percentile_us_e", precision: 22, scale: 6
    t.decimal "percentile_us_s", precision: 22, scale: 6
    t.decimal "percentile_us_g", precision: 22, scale: 6
    t.decimal "percentile_us_esg", precision: 22, scale: 6
    t.decimal "percentile_us_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_controversy", precision: 22, scale: 6
    t.decimal "quantile_us_e1", precision: 22, scale: 6
    t.decimal "quantile_us_e2", precision: 22, scale: 6
    t.decimal "quantile_us_e3", precision: 22, scale: 6
    t.decimal "quantile_us_emp1", precision: 22, scale: 6
    t.decimal "quantile_us_emp2", precision: 22, scale: 6
    t.decimal "quantile_us_emp3", precision: 22, scale: 6
    t.decimal "quantile_us_cit1", precision: 22, scale: 6
    t.decimal "quantile_us_cit2", precision: 22, scale: 6
    t.decimal "quantile_us_cit3", precision: 22, scale: 6
    t.decimal "quantile_us_g1", precision: 22, scale: 6
    t.decimal "quantile_us_g2", precision: 22, scale: 6
    t.decimal "quantile_us_g3", precision: 22, scale: 6
    t.decimal "quantile_us_e", precision: 22, scale: 6
    t.decimal "quantile_us_s", precision: 22, scale: 6
    t.decimal "quantile_us_g", precision: 22, scale: 6
    t.decimal "quantile_us_esg", precision: 22, scale: 6
    t.decimal "quantile_us_carbon", precision: 22, scale: 6
    t.decimal "quantile_us_diversity", precision: 22, scale: 6
    t.decimal "quantile_us_controversy", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_e1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_e2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_e3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_g1", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_g2", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_g3", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_e", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_s", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_g", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_esg", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_lg_cap_controversy", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_e1", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_e2", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_e3", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_emp1", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_emp2", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_emp3", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_cit1", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_cit2", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_cit3", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_g1", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_g2", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_g3", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_e", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_s", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_g", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_esg", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_carbon", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_diversity", precision: 22, scale: 6
    t.decimal "quantile_us_lg_cap_controversy", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_e1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_e2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_e3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_g1", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_g2", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_g3", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_e", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_s", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_g", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_esg", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_sm_cap_controversy", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_e1", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_e2", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_e3", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_emp1", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_emp2", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_emp3", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_cit1", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_cit2", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_cit3", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_g1", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_g2", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_g3", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_e", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_s", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_g", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_esg", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_carbon", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_diversity", precision: 22, scale: 6
    t.decimal "quantile_us_sm_cap_controversy", precision: 22, scale: 6
    t.decimal "forecast_impact_e1", precision: 22, scale: 6
    t.decimal "forecast_impact_e2", precision: 22, scale: 6
    t.decimal "forecast_impact_e3", precision: 22, scale: 6
    t.decimal "forecast_impact_emp1", precision: 22, scale: 6
    t.decimal "forecast_impact_emp2", precision: 22, scale: 6
    t.decimal "forecast_impact_emp3", precision: 22, scale: 6
    t.decimal "forecast_impact_cit1", precision: 22, scale: 6
    t.decimal "forecast_impact_cit2", precision: 22, scale: 6
    t.decimal "forecast_impact_cit3", precision: 22, scale: 6
    t.decimal "forecast_impact_g1", precision: 22, scale: 6
    t.decimal "forecast_impact_g2", precision: 22, scale: 6
    t.decimal "forecast_impact_g3", precision: 22, scale: 6
    t.decimal "forecast_impact_e", precision: 22, scale: 6
    t.decimal "forecast_impact_s", precision: 22, scale: 6
    t.decimal "forecast_impact_g", precision: 22, scale: 6
    t.decimal "forecast_impact_esg", precision: 22, scale: 6
    t.decimal "forecast_impact_carbon", precision: 22, scale: 6
    t.decimal "forecast_impact_diversity", precision: 22, scale: 6
    t.decimal "forecast_impact_controversy", precision: 22, scale: 6
    t.decimal "historic_model_ex_market", precision: 22, scale: 6
    t.decimal "historic_model_ex_market_sector", precision: 22, scale: 6
    t.decimal "dynamic_model_ex_market", precision: 22, scale: 6
    t.decimal "dynamic_model_ex_market_sector", precision: 22, scale: 6
    t.index ["etfg_date", "industry"], name: "index_esg_cores_on_etfg_date_and_industry"
    t.index ["etfg_date", "isin"], name: "index_esg_cores_on_etfg_date_and_isin"
    t.index ["etfg_date", "region"], name: "index_esg_cores_on_etfg_date_and_region"
    t.index ["etfg_date", "sector"], name: "index_esg_cores_on_etfg_date_and_sector"
    t.index ["etfg_date"], name: "index_esg_cores_on_etfg_date"
    t.index ["industry"], name: "index_esg_cores_on_industry"
    t.index ["isin"], name: "index_esg_cores_on_isin"
    t.index ["region"], name: "index_esg_cores_on_region"
    t.index ["sector"], name: "index_esg_cores_on_sector"
  end

  create_table "esg_instruments", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "ticker", limit: 64
    t.string "exchange_country", limit: 64
    t.string "currency", limit: 16
    t.string "standard_name", limit: 128
    t.text "name_variants"
    t.string "figi", limit: 12
    t.boolean "is_exchange_figi"
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "secid", limit: 12
    t.string "cusip_validated", limit: 16
    t.string "exchange", limit: 64
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.string "sector", limit: 64
    t.string "industry", limit: 64
    t.string "industry_group", limit: 128
    t.string "subindustry", limit: 128
    t.string "rating", limit: 32
    t.string "geography", limit: 3
    t.string "asset_class", limit: 128
    t.integer "datasource_id"
    t.boolean "approved", default: false, null: false
    t.boolean "is_valid", default: false, null: false
    t.boolean "default_instrument", default: false, null: false
    t.text "notes"
  end

  create_table "esg_pooled_instruments", force: :cascade do |t|
    t.bigint "pooled_instrument_id", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "exchange_country", limit: 64, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "standard_composite_name", limit: 128, null: false
    t.text "composite_name_variants", null: false
    t.string "composite_description"
    t.string "issuer", limit: 64
    t.boolean "is_index", default: false, null: false
    t.boolean "is_active"
    t.boolean "is_etn"
    t.boolean "is_levered"
    t.boolean "is_inverse"
    t.boolean "has_derivatives"
    t.boolean "options_available"
    t.date "inception_date"
    t.string "etp_structure_type", limit: 50
    t.string "category", limit: 28
    t.string "related_index_symbol", limit: 16
    t.decimal "net_expenses", precision: 18, scale: 6
    t.decimal "expense_ratio", precision: 18, scale: 6
    t.string "listing_exchange", limit: 64
    t.string "asset_class", limit: 28
    t.string "development_class", limit: 32
    t.string "focus", limit: 28
    t.string "lead_market_maker", limit: 128
    t.string "region", limit: 28
    t.decimal "levered_amount", precision: 18, scale: 6
    t.date "maturity_date"
    t.string "exposure_country", limit: 64
    t.string "selection_criteria", limit: 32
    t.string "weighting_scheme", limit: 32
    t.string "administrator", limit: 128
    t.string "advisor", limit: 128
    t.string "distributor", limit: 128
    t.decimal "fee_waivers", precision: 18, scale: 6
    t.string "fiscal_year_end", limit: 16
    t.string "futures_commission_merchant", limit: 128
    t.string "subadvisor", limit: 128
    t.string "tax_classification", limit: 128
    t.string "transfer_agent", limit: 50
    t.string "trustee", limit: 128
    t.decimal "creation_fee", precision: 18, scale: 6
    t.decimal "creation_unit_size", precision: 18, scale: 6
    t.string "custodian", limit: 128
    t.string "distribution_frequency", limit: 32
    t.decimal "management_fee", precision: 18, scale: 6
    t.string "portfolio_manager"
    t.string "primary_benchmark"
    t.decimal "total_expenses", precision: 18, scale: 6
    t.decimal "other_expenses", precision: 18, scale: 6
    t.boolean "approved", default: false, null: false
    t.string "figi", limit: 12
    t.boolean "is_exchange_figi"
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "secid", limit: 12
    t.integer "datasource_id"
  end

  create_table "esg_ratings", force: :cascade do |t|
    t.date "etfg_date"
    t.date "rating_date"
    t.string "composite_ticker"
    t.decimal "e1", precision: 22, scale: 6
    t.decimal "e2", precision: 22, scale: 6
    t.decimal "e3", precision: 22, scale: 6
    t.decimal "emp1", precision: 22, scale: 6
    t.decimal "emp2", precision: 22, scale: 6
    t.decimal "emp3", precision: 22, scale: 6
    t.decimal "cit1", precision: 22, scale: 6
    t.decimal "cit2", precision: 22, scale: 6
    t.decimal "cit3", precision: 22, scale: 6
    t.decimal "g1", precision: 22, scale: 6
    t.decimal "g2", precision: 22, scale: 6
    t.decimal "g3", precision: 22, scale: 6
    t.decimal "e", precision: 22, scale: 6
    t.decimal "s", precision: 22, scale: 6
    t.decimal "g", precision: 22, scale: 6
    t.decimal "carbon", precision: 22, scale: 6
    t.decimal "diversity", precision: 22, scale: 6
    t.decimal "controversy", precision: 22, scale: 6
    t.decimal "percentile_us_e1", precision: 22, scale: 6
    t.decimal "percentile_us_e2", precision: 22, scale: 6
    t.decimal "percentile_us_e3", precision: 22, scale: 6
    t.decimal "percentile_us_emp1", precision: 22, scale: 6
    t.decimal "percentile_us_emp2", precision: 22, scale: 6
    t.decimal "percentile_us_emp3", precision: 22, scale: 6
    t.decimal "percentile_us_cit1", precision: 22, scale: 6
    t.decimal "percentile_us_cit2", precision: 22, scale: 6
    t.decimal "percentile_us_cit3", precision: 22, scale: 6
    t.decimal "percentile_us_g1", precision: 22, scale: 6
    t.decimal "percentile_us_g2", precision: 22, scale: 6
    t.decimal "percentile_us_g3", precision: 22, scale: 6
    t.decimal "percentile_us_e", precision: 22, scale: 6
    t.decimal "percentile_us_s", precision: 22, scale: 6
    t.decimal "percentile_us_g", precision: 22, scale: 6
    t.decimal "percentile_us_esg", precision: 22, scale: 6
    t.decimal "percentile_us_carbon", precision: 22, scale: 6
    t.decimal "percentile_us_diversity", precision: 22, scale: 6
    t.decimal "percentile_us_controversy", precision: 22, scale: 6
    t.decimal "quantile_us_e1", precision: 22, scale: 6
    t.decimal "quantile_us_e2", precision: 22, scale: 6
    t.decimal "quantile_us_e3", precision: 22, scale: 6
    t.decimal "quantile_us_emp1", precision: 22, scale: 6
    t.decimal "quantile_us_emp2", precision: 22, scale: 6
    t.decimal "quantile_us_emp3", precision: 22, scale: 6
    t.decimal "quantile_us_cit1", precision: 22, scale: 6
    t.decimal "quantile_us_cit2", precision: 22, scale: 6
    t.decimal "quantile_us_cit3", precision: 22, scale: 6
    t.decimal "quantile_us_g1", precision: 22, scale: 6
    t.decimal "quantile_us_g2", precision: 22, scale: 6
    t.decimal "quantile_us_g3", precision: 22, scale: 6
    t.decimal "quantile_us_e", precision: 22, scale: 6
    t.decimal "quantile_us_s", precision: 22, scale: 6
    t.decimal "quantile_us_g", precision: 22, scale: 6
    t.decimal "quantile_us_esg", precision: 22, scale: 6
    t.decimal "quantile_us_carbon", precision: 22, scale: 6
    t.decimal "quantile_us_diversity", precision: 22, scale: 6
    t.decimal "quantile_us_controversy", precision: 22, scale: 6
    t.decimal "forecast_impact_e1", precision: 22, scale: 6
    t.decimal "forecast_impact_e2", precision: 22, scale: 6
    t.decimal "forecast_impact_e3", precision: 22, scale: 6
    t.decimal "forecast_impact_emp1", precision: 22, scale: 6
    t.decimal "forecast_impact_emp2", precision: 22, scale: 6
    t.decimal "forecast_impact_emp3", precision: 22, scale: 6
    t.decimal "forecast_impact_cit1", precision: 22, scale: 6
    t.decimal "forecast_impact_cit2", precision: 22, scale: 6
    t.decimal "forecast_impact_cit3", precision: 22, scale: 6
    t.decimal "forecast_impact_g1", precision: 22, scale: 6
    t.decimal "forecast_impact_g2", precision: 22, scale: 6
    t.decimal "forecast_impact_g3", precision: 22, scale: 6
    t.decimal "forecast_impact_e", precision: 22, scale: 6
    t.decimal "forecast_impact_s", precision: 22, scale: 6
    t.decimal "forecast_impact_g", precision: 22, scale: 6
    t.decimal "forecast_impact_esg", precision: 22, scale: 6
    t.decimal "forecast_impact_carbon", precision: 22, scale: 6
    t.decimal "forecast_impact_diversity", precision: 22, scale: 6
    t.decimal "forecast_impact_controversy", precision: 22, scale: 6
    t.decimal "historic_model_ex_market", precision: 22, scale: 6
    t.decimal "historic_model_ex_market_sector", precision: 22, scale: 6
    t.decimal "dynamic_model_ex_market", precision: 22, scale: 6
    t.decimal "dynamic_model_ex_market_sector", precision: 22, scale: 6
    t.index ["composite_ticker"], name: "index_esg_ratings_on_composite_ticker"
    t.index ["etfg_date", "composite_ticker"], name: "index_esg_ratings_on_etfg_date_and_composite_ticker"
    t.index ["etfg_date"], name: "index_esg_ratings_on_etfg_date"
  end

  create_table "esg_ratings_template", id: false, force: :cascade do |t|
    t.text "rating_date"
    t.text "composite_ticker"
    t.text "e1"
    t.text "e2"
    t.text "e3"
    t.text "emp1"
    t.text "emp2"
    t.text "emp3"
    t.text "cit1"
    t.text "cit2"
    t.text "cit3"
    t.text "g1"
    t.text "g2"
    t.text "g3"
    t.text "e"
    t.text "s"
    t.text "g"
    t.text "esg"
    t.text "carbon"
    t.text "diversity"
    t.text "controversy"
    t.text "percentile_us_e1"
    t.text "percentile_us_e2"
    t.text "percentile_us_e3"
    t.text "percentile_us_emp1"
    t.text "percentile_us_emp2"
    t.text "percentile_us_emp3"
    t.text "percentile_us_cit1"
    t.text "percentile_us_cit2"
    t.text "percentile_us_cit3"
    t.text "percentile_us_g1"
    t.text "percentile_us_g2"
    t.text "percentile_us_g3"
    t.text "percentile_us_e"
    t.text "percentile_us_s"
    t.text "percentile_us_g"
    t.text "percentile_us_esg"
    t.text "percentile_us_carbon"
    t.text "percentile_us_diversity"
    t.text "percentile_us_controversy"
    t.text "quantile_us_e1"
    t.text "quantile_us_e2"
    t.text "quantile_us_e3"
    t.text "quantile_us_emp1"
    t.text "quantile_us_emp2"
    t.text "quantile_us_emp3"
    t.text "quantile_us_cit1"
    t.text "quantile_us_cit2"
    t.text "quantile_us_cit3"
    t.text "quantile_us_g1"
    t.text "quantile_us_g2"
    t.text "quantile_us_g3"
    t.text "quantile_us_e"
    t.text "quantile_us_s"
    t.text "quantile_us_g"
    t.text "quantile_us_esg"
    t.text "quantile_us_carbon"
    t.text "quantile_us_diversity"
    t.text "quantile_us_controversy"
    t.text "forecast_impact_e1"
    t.text "forecast_impact_e2"
    t.text "forecast_impact_e3"
    t.text "forecast_impact_emp1"
    t.text "forecast_impact_emp2"
    t.text "forecast_impact_emp3"
    t.text "forecast_impact_cit1"
    t.text "forecast_impact_cit2"
    t.text "forecast_impact_cit3"
    t.text "forecast_impact_g1"
    t.text "forecast_impact_g2"
    t.text "forecast_impact_g3"
    t.text "forecast_impact_e"
    t.text "forecast_impact_s"
    t.text "forecast_impact_g"
    t.text "forecast_impact_esg"
    t.text "forecast_impact_carbon"
    t.text "forecast_impact_diversity"
    t.text "forecast_impact_controversy"
    t.text "historic_model_ex_market"
    t.text "historic_model_ex_market_sector"
    t.text "dynamic_model_ex_market"
    t.text "dynamic_model_ex_market_sector"
  end

  create_table "fund_flows", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "value", precision: 22, scale: 6
    t.string "region", limit: 2
    t.string "country", limit: 2
    t.index ["composite_ticker"], name: "index_fund_flows_on_composite_ticker_v2"
    t.index ["region"], name: "index_fund_flows_country"
    t.index ["run_date", "region", "country", "composite_ticker"], name: "index_fund_flows_date_ticker_country_region", unique: true
    t.index ["run_date"], name: "index_fund_flows_on_run_date_v2"
  end

  create_table "industries", force: :cascade do |t|
    t.date "run_date", null: false
    t.date "as_of_date"
    t.string "composite_ticker", limit: 12, null: false
    t.string "issuer", limit: 64
    t.string "name", limit: 128
    t.date "inception_date"
    t.string "related_index", limit: 128
    t.string "tax_classification", limit: 32
    t.boolean "is_etn"
    t.decimal "fund_aum", precision: 22, scale: 6
    t.string "avg_volume", limit: 32
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
    t.decimal "creation_unit_size", precision: 22, scale: 6
    t.decimal "creation_fee", precision: 22, scale: 6
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
    t.decimal "short_interest", precision: 22, scale: 6
    t.string "put_call_ratio", limit: 32
    t.decimal "num_constituents", precision: 22, scale: 6
    t.decimal "discount_premium", precision: 22, scale: 6
    t.decimal "bid_ask_spread", precision: 22, scale: 6
    t.string "put_vol"
    t.string "call_vol"
    t.decimal "management_fee", precision: 22, scale: 6
    t.decimal "other_expenses", precision: 22, scale: 6
    t.decimal "total_expenses", precision: 22, scale: 6
    t.decimal "fee_waivers", precision: 22, scale: 6
    t.decimal "net_expenses", precision: 22, scale: 6
    t.string "lead_market_maker", limit: 64
    t.string "output_region", limit: 2
    t.index ["composite_ticker"], name: "index_industries_on_composite_ticker_v2"
    t.index ["run_date", "composite_ticker", "output_region"], name: "index_on_date_ticker_region", unique: true
    t.index ["run_date"], name: "index_industries_on_run_date_v2"
  end

end
