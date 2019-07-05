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

require 'rails_helper'

RSpec.describe Constituent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
