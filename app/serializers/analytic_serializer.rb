class AnalyticSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :composite_ticker, :quant_grade, :risk_total_score, :risk_volatility, :risk_deviation, :risk_country, :risk_structure, 
             :risk_liquidity, :risk_efficiency, :reward_score, :quant_tota_score, :quant_technical_st, :quant_technical_it, :quant_technical_lt, 
             :quant_composite_technical, :quant_sentiment_pc, :quant_sentiment_si, :quant_sentiment_iv, :quant_composite_sentiment, 
             :quant_composite_behavioral, :quant_fundamental_pe, :quant_fundamental_pcf, :quant_fundamental_pb, :quant_fundamental_div, 
             :quant_composite_fundamental, :quant_global_sector, :quant_global_country, :quant_composite_global, :quant_quality_liquidity, 
             :quant_quality_diversification, :quant_quality_firm, :quant_composite_quality
end
