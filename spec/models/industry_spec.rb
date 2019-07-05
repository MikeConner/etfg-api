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
#  discount_premium            :decimal(, )
#  bid_ask_spread              :decimal(16, 12)
#  put_vol                     :string
#  call_vol                    :string
#  management_fee              :decimal(12, 4)
#  other_expenses              :decimal(12, 4)
#  total_expenses              :decimal(12, 4)
#  fee_waivers                 :decimal(12, 4)
#  net_expenses                :decimal(12, 4)
#  lead_market_maker           :string(64)
#

require 'rails_helper'

RSpec.describe Industry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
