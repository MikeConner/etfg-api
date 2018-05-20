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

require 'rails_helper'

RSpec.describe FundFlow, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
