# == Schema Information
#
# Table name: constituents
#
#  id                :bigint(8)        not null, primary key
#  run_date          :date             not null
#  as_of_date        :date
#  composite_ticker  :string(12)       not null
#  identifier        :string(64)
#  constituent_name  :string
#  weight            :decimal(18, 10)
#  market_value      :decimal(22, 6)
#  cusip             :string(24)
#  isin              :string(16)
#  figi              :string(16)
#  sedol             :string(16)
#  country           :string(32)
#  exchange          :string(64)
#  total_shares_held :decimal(22, 6)
#  market_sector     :string(128)
#  security_type     :string(128)
#  currency          :string(16)
#  region            :string(2)
#  base_currency     :string(16)
#

class ConstituentV2 < EtfgDbV2Base
  self.record_timestamps = false
  self.table_name = 'constituents'
  
  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum =>12, :allow_nil => true
  validates_numericality_of :weight, :market_value, :total_shares_held, :allow_nil => true
  validates_length_of :cusip, :maximum => 24, :allow_nil => true
  validates_length_of :isin, :figi, :sedol, :currency, :base_currency, :maximum => 16, :allow_nil => true
  validates_length_of :country, :maximum => 32, :allow_nil => true
  validates_length_of :identifier, :exchange, :maximum => 64, :allow_nil => true
  validates_length_of :market_sector, :security_type, :maximum => 128, :allow_nil => true
  validates_length_of :region, :maximum => 2
  
  scope :weighted, -> {where('weight IS NOT NULL')}
end
