# == Schema Information
#
# Table name: esg_instruments
#
#  id                 :bigint(8)        not null, primary key
#  instrument_id      :bigint(8)        not null
#  effective_date     :date
#  expiration_date    :date
#  ticker             :string(64)
#  exchange_country   :string(64)
#  currency           :string(16)
#  standard_name      :string(128)
#  name_variants      :text
#  figi               :string(12)
#  is_exchange_figi   :boolean
#  sedol              :string(7)
#  isin               :string(12)
#  cusip              :string(9)
#  secid              :string(12)
#  cusip_validated    :string(16)
#  exchange           :string(64)
#  market_sector      :string(128)
#  security_type      :string(128)
#  sector             :string(64)
#  industry           :string(64)
#  industry_group     :string(128)
#  subindustry        :string(128)
#  rating             :string(32)
#  geography          :string(3)
#  asset_class        :string(128)
#  datasource_id      :integer
#  approved           :boolean          default(FALSE), not null
#  is_valid           :boolean          default(FALSE), not null
#  default_instrument :boolean          default(FALSE), not null
#  notes              :text
#

class EsgInstrument < EtfgDbV2Base
  self.record_timestamps = false

 def self.date_range(date)
    #date = date_param.try(:strftime, "%Y%m%d")
    clause = "((effective_date IS NULL AND expiration_date IS NULL) OR " +
              "(effective_date IS NULL AND expiration_date IS NOT NULL AND '#{date}' <= expiration_date) OR " +
              "(effective_date IS NOT NULL AND expiration_date IS NULL AND '#{date}' > effective_date) OR " +
              "(effective_date IS NOT NULL AND expiration_date IS NOT NULL AND '#{date}' > effective_date AND '#{date}' <= expiration_date))"
    EsgInstrument.where(clause)
  end
end
