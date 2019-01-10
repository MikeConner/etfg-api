# == Schema Information
#
# Table name: fund_flows
#
#  id               :bigint(8)        not null, primary key
#  run_date         :date             not null
#  as_of_date       :date
#  composite_ticker :string(12)       not null
#  shares           :decimal(14, 2)
#  nav              :decimal(14, 6)
#  value            :decimal(20, 6)
#

class FundFlowV2 < EtfgDbV2Base
  self.record_timestamps = false
  self.table_name = 'fund_flows'

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 8
  validates_numericality_of :shares, :nav, :value, :allow_nil => true
end
