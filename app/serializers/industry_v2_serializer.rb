# == Schema Information
#
# Table name: industries
#
#  id                          :bigint(8)        not null, primary key
#  run_date                    :date             not null
#  as_of_date                  :date
#  composite_ticker            :string(12)       not null
#  issuer                      :string(64)
#  name                        :string(128)
#  inception_date              :date
#  related_index               :string
#  tax_classification          :string(32)
#  is_etn                      :boolean
#  fund_aum                    :decimal(22, 6)
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
#  creation_unit_size          :decimal(22, 6)
#  creation_fee                :decimal(22, 6)
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
#  short_interest              :decimal(22, 6)
#  put_call_ratio              :string(32)
#  num_constituents            :decimal(22, 6)
#  discount_premium            :decimal(22, 6)
#  bid_ask_spread              :decimal(22, 6)
#  put_vol                     :string
#  call_vol                    :string
#  management_fee              :decimal(22, 6)
#  other_expenses              :decimal(22, 6)
#  total_expenses              :decimal(22, 6)
#  fee_waivers                 :decimal(22, 6)
#  net_expenses                :decimal(22, 6)
#  lead_market_maker           :string(64)
#  output_region               :string(2)
#

class IndustryV2Serializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :as_of_date, :composite_ticker, :issuer, :name, :inception_date, :related_index, :tax_classification, :is_etn, :fund_aum,
             :avg_volume, :asset_class, :category, :focus, :development_level, :region, :is_leveraged, :leverage_factor, :active,
             :administrator, :advisor, :custodian, :distributor, :portfolio_manager, :subadvisor, :transfer_agent, :trustee,
             :futures_commission_merchant, :fiscal_year_end, :distribution_frequency, :listing_exchange, :creation_unit_size,
             :creation_fee, :geographic_exposure, :currency_exposure, :sector_exposure, :industry_group_exposure, :industry_exposure,
             :subindustry_exposure, :coupon_exposure, :maturity_exposure, :option_available, :option_volume, :short_interest,
             :put_call_ratio, :num_constituents, :discount_premium, :bid_ask_spread, :put_vol, :call_vol, :management_fee,
             :other_expenses, :total_expenses, :fee_waivers, :net_expenses, :lead_market_maker

  attribute :security_type do |obj|
    if obj.is_etn
      'ETN'
    else
      ['Currency', 'Commodity'].include?(obj.asset_class) ? 'ETC' : 'ETF'
    end
  end
    
  def self.extract(batch)
    result = []

    parsed = JSON.parse(IndustryV2Serializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
