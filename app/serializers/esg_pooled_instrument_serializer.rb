# == Schema Information
#
# Table name: esg_pooled_instruments
#
#  id                          :bigint(8)        not null, primary key
#  pooled_instrument_id        :bigint(8)        not null
#  composite_ticker            :string(32)       not null
#  exchange_country            :string(64)       not null
#  effective_date              :date
#  expiration_date             :date
#  standard_composite_name     :string(128)      not null
#  composite_name_variants     :text             not null
#  composite_description       :string
#  issuer                      :string(64)
#  is_index                    :boolean          default(FALSE), not null
#  is_active                   :boolean
#  is_etn                      :boolean
#  is_levered                  :boolean
#  is_inverse                  :boolean
#  has_derivatives             :boolean
#  options_available           :boolean
#  inception_date              :date
#  etp_structure_type          :string(50)
#  category                    :string(28)
#  related_index_symbol        :string(16)
#  net_expenses                :decimal(18, 6)
#  expense_ratio               :decimal(18, 6)
#  listing_exchange            :string(64)
#  asset_class                 :string(28)
#  development_class           :string(32)
#  focus                       :string(28)
#  lead_market_maker           :string(128)
#  region                      :string(28)
#  levered_amount              :decimal(18, 6)
#  maturity_date               :date
#  exposure_country            :string(64)
#  selection_criteria          :string(32)
#  weighting_scheme            :string(32)
#  administrator               :string(128)
#  advisor                     :string(128)
#  distributor                 :string(128)
#  fee_waivers                 :decimal(18, 6)
#  fiscal_year_end             :string(16)
#  futures_commission_merchant :string(128)
#  subadvisor                  :string(128)
#  tax_classification          :string(128)
#  transfer_agent              :string(50)
#  trustee                     :string(128)
#  creation_fee                :decimal(18, 6)
#  creation_unit_size          :decimal(18, 6)
#  custodian                   :string(128)
#  distribution_frequency      :string(32)
#  management_fee              :decimal(18, 6)
#  portfolio_manager           :string
#  primary_benchmark           :string
#  total_expenses              :decimal(18, 6)
#  other_expenses              :decimal(18, 6)
#  approved                    :boolean          default(FALSE), not null
#  figi                        :string(12)
#  is_exchange_figi            :boolean
#  sedol                       :string(7)
#  isin                        :string(12)
#  cusip                       :string(9)
#  secid                       :string(12)
#  datasource_id               :integer
#

class EsgPooledInstrumentSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :pooled_instrument_id, :region, :composite_ticker, :exchange_country, :standard_composite_name, :composite_name_variants,
             :composite_description, :issuer, :is_index, :is_active, :is_etn, :is_levered, :is_inverse, :has_derivatives, :options_available, 
             :inception_date, :etp_structure_type, :category, :related_index_symbol, :net_expenses, :expense_ratio, :listing_exchange, 
             :asset_class, :development_class, :focus, :lead_market_maker, :levered_amount, :maturity_date, :exposure_country, 
             :selection_criteria, :weighting_scheme, :administrator, :advisor, :distributor, :fee_waivers, :fiscal_year_end, 
             :futures_commission_merchant, :subadvisor, :tax_classification, :transfer_agent, :trustee, :creation_fee, :creation_unit_size, 
             :custodian, :distribution_frequency, :management_fee, :portfolio_manager, :primary_benchmark, :total_expenses, :other_expenses, 
             :approved, :figi, :is_exchange_figi, :sedol, :isin, :cusip, :secid, :datasource_id

 
  def self.extract(batch)
    result = []

    parsed = JSON.parse(EsgPooledInstrumentSerializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
