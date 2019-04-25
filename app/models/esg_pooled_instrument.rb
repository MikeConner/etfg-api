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

class EsgPooledInstrument < EtfgDbV2Base
  self.record_timestamps = false

 def self.date_range(date, ensure_no_dups = false)
    #date = date_param.try(:strftime, "%Y%m%d")
    clause = "((effective_date IS NULL AND expiration_date IS NULL) OR " +
              "(effective_date IS NULL AND expiration_date IS NOT NULL AND '#{date}' <= expiration_date) OR " +
              "(effective_date IS NOT NULL AND expiration_date IS NULL AND '#{date}' > effective_date) OR " +
              "(effective_date IS NOT NULL AND expiration_date IS NOT NULL AND '#{date}' > effective_date AND '#{date}' <= expiration_date))"
    ensure_no_dups ? EsgPooledInstrument.find(EsgPooledInstrument.where(clause).order(:id).map {|i| i.pooled_instrument_id}.uniq) : 
                     EsgPooledInstrument.where(clause)
  end
end
