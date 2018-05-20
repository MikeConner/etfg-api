# == Schema Information
#
# Table name: fund_flows
#
#  id               :bigint(8)        not null, primary key
#  run_date         :date             not null
#  composite_ticker :string(8)        not null
#  shares           :decimal(14, 2)
#  nav              :decimal(14, 6)
#  value            :decimal(20, 6)
#

class FundFlow < ApplicationRecord
  self.record_timestamps = false

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 8
  validates_numericality_of :shares, :nav, :value, :allow_nil => true
end
