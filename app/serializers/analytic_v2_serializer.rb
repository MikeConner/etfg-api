# == Schema Information
#
# Table name: analytics
#
#  id                            :bigint(8)        not null, primary key
#  run_date                      :date             not null
#  as_of_date                    :date
#  composite_ticker              :string(12)       not null
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
#

class AnalyticV2Serializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :as_of_date, :composite_ticker, :quant_grade, :risk_total_score, :risk_volatility, :risk_deviation, :risk_country, :risk_structure, 
             :risk_liquidity, :risk_efficiency, :reward_score, :quant_total_score, :quant_technical_st, :quant_technical_it, :quant_technical_lt, 
             :quant_composite_technical, :quant_sentiment_pc, :quant_sentiment_si, :quant_sentiment_iv, :quant_composite_sentiment, 
             :quant_composite_behavioral, :quant_fundamental_pe, :quant_fundamental_pcf, :quant_fundamental_pb, :quant_fundamental_div, 
             :quant_composite_fundamental, :quant_global_sector, :quant_global_country, :quant_composite_global, :quant_quality_liquidity, 
             :quant_quality_diversification, :quant_quality_firm, :quant_composite_quality

  def self.extract(batch)
    result = []

    parsed = JSON.parse(AnalyticV2Serializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
