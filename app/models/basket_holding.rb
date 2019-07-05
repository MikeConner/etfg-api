# == Schema Information
#
# Table name: basket_holdings
#
#  id                 :bigint(8)        not null, primary key
#  run_date           :date             not null
#  as_of_date         :date
#  composite_ticker   :string(32)       not null
#  exchange_country   :string(16)       not null
#  composite_name     :string(128)
#  issuer             :string(32)
#  constituent_ticker :string(64)
#  constituent_name   :string(128)
#  cusip              :string(9)
#  figi               :string(12)
#  isin               :string(12)
#  sedol              :string(7)
#  market_value       :decimal(22, 6)
#  basket_weight      :decimal(18, 10)
#  holdings_weight    :decimal(18, 10)
#  weight_diff        :decimal(18, 10)
#  total_shares_held  :decimal(22, 6)
#  cash_in_lieu_flag  :boolean
#  new_security_flag  :boolean
#  output_region      :string(2)
#

class BasketHolding < EtfgDbV2Base
  self.record_timestamps = false

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 32
  validates_length_of :exchange_country, :maximum => 16, :allow_nil => true
  validates_length_of :composite_name, :maximum => 128, :allow_nil => true
  validates_length_of :issuer, :maximum => 32, :allow_nil => true
  validates_length_of :cusip, :is => 9, :allow_nil => true
  validates_length_of :isin, :figi, :is => 12, :allow_nil => true
  validates_length_of :sedol, :is => 7, :allow_nil => true
  validates_length_of :output_region, :is => 2
  validates_numericality_of :market_value, :basket_weight, :holdings_weight, :weight_diff, :total_shares_held,
                            :allow_nil => true
  validates_inclusion_of :cash_in_lieu_flag, :new_security_flag, :in => [true, false], :allow_nil => true
end
