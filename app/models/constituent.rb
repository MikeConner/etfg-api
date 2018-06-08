# == Schema Information
#
# Table name: constituents
#
#  id                :bigint(8)        not null, primary key
#  run_date          :date             not null
#  composite_ticker  :string(12)       not null
#  identifier        :string(32)
#  constituent_name  :string
#  weight            :decimal(10, 6)
#  market_value      :decimal(20, 6)
#  cusip             :string(24)
#  isin              :string(16)
#  figi              :string(16)
#  sedol             :string(16)
#  country           :string(32)
#  exchange          :string(16)
#  total_shares_held :decimal(18, 4)
#  market_sector     :string(128)
#  security_type     :string(128)
#

class Constituent < ApplicationRecord
  self.record_timestamps = false
  
  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 8, :allow_nil => true
  validates_numericality_of :weight, :market_value, :total_shares_held, :allow_nil => true
  validates_length_of :cusip, :maximum => 24, :allow_nil => true
  validates_length_of :isin, :figi, :sedol, :exchange, :maximum => 16, :allow_nil => true
  validates_length_of :country, :maximum => 32, :allow_nil => true
  validates_length_of :market_sector, :security_type, :maximum => 128, :allow_nil => true
end
