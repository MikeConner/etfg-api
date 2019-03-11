# == Schema Information
#
# Table name: fund_flows
#
#  id               :bigint(8)        not null, primary key
#  run_date         :date             not null
#  as_of_date       :date
#  composite_ticker :string(12)       not null
#  shares           :decimal(22, 6)
#  nav              :decimal(22, 6)
#  value            :decimal(22, 6)
#  region           :string(2)
#  country          :string(2)
#

class FundFlowV2 < EtfgDbV2Base
  self.record_timestamps = false
  self.table_name = 'fund_flows'

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 8
  validates_numericality_of :shares, :nav, :value, :allow_nil => true
  validates_length_of :region, :country, :maximum => 2
end
