# == Schema Information
#
# Table name: analytics
#
#  id                            :bigint(8)        not null, primary key
#  run_date                      :date             not null
#  composite_ticker              :string(8)        not null
#  risk_total_score              :decimal(16, 4)
#  risk_volatility               :decimal(16, 4)
#  risk_deviation                :decimal(16, 4)
#  risk_country                  :decimal(16, 4)
#  risk_structure                :decimal(16, 4)
#  risk_liquidity                :decimal(16, 4)
#  risk_efficiency               :decimal(16, 4)
#  reward_score                  :decimal(16, 4)
#  quant_total_score             :decimal(16, 4)
#  quant_technical_st            :decimal(16, 4)
#  quant_technical_it            :decimal(16, 4)
#  quant_technical_lt            :decimal(16, 4)
#  quant_composite_technical     :decimal(16, 4)
#  quant_sentiment_pc            :decimal(16, 4)
#  quant_sentiment_si            :decimal(16, 4)
#  quant_sentiment_iv            :decimal(16, 4)
#  quant_composite_sentiment     :decimal(16, 4)
#  quant_composite_behavioral    :decimal(16, 4)
#  quant_fundamental_pe          :decimal(16, 4)
#  quant_fundamental_pcf         :decimal(16, 4)
#  quant_fundamental_pb          :decimal(16, 4)
#  quant_fundamental_div         :decimal(16, 4)
#  quant_composite_fundamental   :decimal(16, 4)
#  quant_global_sector           :decimal(16, 4)
#  quant_global_country          :decimal(16, 4)
#  quant_composite_global        :decimal(16, 4)
#  quant_quality_liquidity       :decimal(16, 4)
#  quant_quality_diversification :decimal(16, 4)
#  quant_quality_firm            :decimal(16, 4)
#  quant_composite_quality       :decimal(16, 4)
#  quant_grade                   :string(1)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

require 'rails_helper'

RSpec.describe Analytic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
