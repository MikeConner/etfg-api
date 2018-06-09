# == Schema Information
#
# Table name: industries
#
#  id                          :bigint(8)        not null, primary key
#  run_date                    :date             not null
#  composite_ticker            :string(12)       not null
#  issuer                      :string(32)
#  name                        :string(128)
#  inception_date              :date
#  related_index               :string(128)
#  tax_classification          :string(32)
#  is_etn                      :boolean
#  fund_aum                    :decimal(24, 6)
#  avg_volume                  :string(10)
#  asset_class                 :string(32)
#  category                    :string(32)
#  focus                       :string(32)
#  development_level           :string(32)
#  region                      :string(32)
#  is_leveraged                :boolean
#  leverage_factor             :string(16)
#  active                      :boolean
#  administrator               :string(64)
#  advisor                     :string(64)
#  custodian                   :string(128)
#  distributor                 :string(128)
#  portfolio_manager           :string
#  subadvisor                  :string(128)
#  transfer_agent              :string(64)
#  trustee                     :string(64)
#  futures_commission_merchant :string(128)
#  fiscal_year_end             :string(16)
#  distribution_frequency      :string(1)
#  listing_exchange            :string(64)
#  creation_unit_size          :decimal(12, )
#  creation_fee                :decimal(8, )
#  geographic_exposure         :text
#  currency_exposure           :text
#  sector_exposure             :text
#  industry_group_exposure     :text
#  industry_exposure           :text
#  subindustry_exposure        :text
#  coupon_exposure             :text
#  maturity_exposure           :text
#  option_available            :boolean
#  option_volume               :string(16)
#  short_interest              :decimal(12, )
#  put_call_ratio              :string(32)
#  num_constituents            :decimal(6, )
#  discount_premium            :decimal(8, 2)
#  bid_ask_spread              :decimal(16, 12)
#  put_vol                     :string(14)
#  call_vol                    :string(14)
#  management_fee              :decimal(12, 4)
#  other_expenses              :decimal(12, 4)
#  total_expenses              :decimal(12, 4)
#  fee_waivers                 :decimal(12, 4)
#  net_expenses                :decimal(12, 4)
#  lead_market_maker           :string(64)
#

class Industry < ApplicationRecord
  self.record_timestamps = false
  
  VALID_EXPOSURES = ['geographic', 'currency', 'sector', 'industry_group', 'industry', 'subindustry', 'coupon', 'maturity']
  
  validates_presence_of :run_date, :composite_ticker
  validates_length_of :distribution_frequency, :is => 1, :allow_nil => true
  validates_length_of :avg_volume,
                      :maximum => 10, :allow_nil => true
  validates_length_of :put_vol, :call_vol,
                      :maximum => 14, :allow_nil => true
  validates_length_of :leverage_factor, :fiscal_year_end, :option_volume,
                      :maximum => 16, :allow_nil => true
  validates_length_of :asset_class, :development_level, :region, :put_call_ratio,
                      :maximum => 32, :allow_nil => true
  validates_length_of :administrator, :advisor, :transfer_agent, :trustee, :listing_exchange, :lead_market_maker, :issuer, :tax_classification,
                      :maximum => 64, :allow_nil => true
  validates_length_of :custodian, :distributor, :subadvisor, :futures_commission_merchant, :related_index, :name,
                      :maximum => 128, :allow_nil => true
  validates_inclusion_of :is_etn, :is_leveraged, :active, :option_available, :in => [true, false, nil]
  validates_numericality_of :fund_aum, :creation_unit_size, :creation_fee, :short_interest, :num_constituents, :discount_premium,
                            :bid_ask_spread, :management_fee, :other_expenses, :total_expenses, :fee_waivers, :net_expenses, :allow_nil => true
end
