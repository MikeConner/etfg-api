# == Schema Information
#
# Table name: esg_ratings
#
#  id                              :bigint(8)        not null, primary key
#  etfg_date                       :date
#  rating_date                     :date
#  composite_ticker                :string
#  e1                              :decimal(22, 6)
#  e2                              :decimal(22, 6)
#  e3                              :decimal(22, 6)
#  emp1                            :decimal(22, 6)
#  emp2                            :decimal(22, 6)
#  emp3                            :decimal(22, 6)
#  cit1                            :decimal(22, 6)
#  cit2                            :decimal(22, 6)
#  cit3                            :decimal(22, 6)
#  g1                              :decimal(22, 6)
#  g2                              :decimal(22, 6)
#  g3                              :decimal(22, 6)
#  e                               :decimal(22, 6)
#  s                               :decimal(22, 6)
#  g                               :decimal(22, 6)
#  carbon                          :decimal(22, 6)
#  diversity                       :decimal(22, 6)
#  controversy                     :decimal(22, 6)
#  percentile_us_e1                :decimal(22, 6)
#  percentile_us_e2                :decimal(22, 6)
#  percentile_us_e3                :decimal(22, 6)
#  percentile_us_emp1              :decimal(22, 6)
#  percentile_us_emp2              :decimal(22, 6)
#  percentile_us_emp3              :decimal(22, 6)
#  percentile_us_cit1              :decimal(22, 6)
#  percentile_us_cit2              :decimal(22, 6)
#  percentile_us_cit3              :decimal(22, 6)
#  percentile_us_g1                :decimal(22, 6)
#  percentile_us_g2                :decimal(22, 6)
#  percentile_us_g3                :decimal(22, 6)
#  percentile_us_e                 :decimal(22, 6)
#  percentile_us_s                 :decimal(22, 6)
#  percentile_us_g                 :decimal(22, 6)
#  percentile_us_esg               :decimal(22, 6)
#  percentile_us_carbon            :decimal(22, 6)
#  percentile_us_diversity         :decimal(22, 6)
#  percentile_us_controversy       :decimal(22, 6)
#  quantile_us_e1                  :decimal(22, 6)
#  quantile_us_e2                  :decimal(22, 6)
#  quantile_us_e3                  :decimal(22, 6)
#  quantile_us_emp1                :decimal(22, 6)
#  quantile_us_emp2                :decimal(22, 6)
#  quantile_us_emp3                :decimal(22, 6)
#  quantile_us_cit1                :decimal(22, 6)
#  quantile_us_cit2                :decimal(22, 6)
#  quantile_us_cit3                :decimal(22, 6)
#  quantile_us_g1                  :decimal(22, 6)
#  quantile_us_g2                  :decimal(22, 6)
#  quantile_us_g3                  :decimal(22, 6)
#  quantile_us_e                   :decimal(22, 6)
#  quantile_us_s                   :decimal(22, 6)
#  quantile_us_g                   :decimal(22, 6)
#  quantile_us_esg                 :decimal(22, 6)
#  quantile_us_carbon              :decimal(22, 6)
#  quantile_us_diversity           :decimal(22, 6)
#  quantile_us_controversy         :decimal(22, 6)
#  forecast_impact_e1              :decimal(22, 6)
#  forecast_impact_e2              :decimal(22, 6)
#  forecast_impact_e3              :decimal(22, 6)
#  forecast_impact_emp1            :decimal(22, 6)
#  forecast_impact_emp2            :decimal(22, 6)
#  forecast_impact_emp3            :decimal(22, 6)
#  forecast_impact_cit1            :decimal(22, 6)
#  forecast_impact_cit2            :decimal(22, 6)
#  forecast_impact_cit3            :decimal(22, 6)
#  forecast_impact_g1              :decimal(22, 6)
#  forecast_impact_g2              :decimal(22, 6)
#  forecast_impact_g3              :decimal(22, 6)
#  forecast_impact_e               :decimal(22, 6)
#  forecast_impact_s               :decimal(22, 6)
#  forecast_impact_g               :decimal(22, 6)
#  forecast_impact_esg             :decimal(22, 6)
#  forecast_impact_carbon          :decimal(22, 6)
#  forecast_impact_diversity       :decimal(22, 6)
#  forecast_impact_controversy     :decimal(22, 6)
#  historic_model_ex_market        :decimal(22, 6)
#  historic_model_ex_market_sector :decimal(22, 6)
#  dynamic_model_ex_market         :decimal(22, 6)
#  dynamic_model_ex_market_sector  :decimal(22, 6)
#

class EsgRatingSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :etfg_date,:rating_date,:composite_ticker,:e1,:e2,:e3,:emp1,:emp2,:emp3,:cit1,:cit2,:cit3,:g1,:g2,:g3,:e,:s,:g,:carbon,:diversity,
             :controversy,:percentile_us_e1,:percentile_us_e2,:percentile_us_e3,:percentile_us_emp1,:percentile_us_emp2,:percentile_us_emp3,
             :percentile_us_cit1,:percentile_us_cit2,:percentile_us_cit3,:percentile_us_g1,:percentile_us_g2,:percentile_us_g3,:percentile_us_e,
             :percentile_us_s,:percentile_us_g,:percentile_us_esg,:percentile_us_carbon,:percentile_us_diversity,:percentile_us_controversy,
             :quantile_us_e1,:quantile_us_e2,:quantile_us_e3,:quantile_us_emp1,:quantile_us_emp2,:quantile_us_emp3,:quantile_us_cit1,
             :quantile_us_cit2,:quantile_us_cit3,:quantile_us_g1,:quantile_us_g2,:quantile_us_g3,:quantile_us_e,:quantile_us_s,:quantile_us_g,
             :quantile_us_esg,:quantile_us_carbon,:quantile_us_diversity,:quantile_us_controversy,:forecast_impact_e1,:forecast_impact_e2,
             :forecast_impact_e3,:forecast_impact_emp1,:forecast_impact_emp2,:forecast_impact_emp3,:forecast_impact_cit1,:forecast_impact_cit2,
             :forecast_impact_cit3,:forecast_impact_g1,:forecast_impact_g2,:forecast_impact_g3,:forecast_impact_e,:forecast_impact_s,
             :forecast_impact_g,:forecast_impact_esg,:forecast_impact_carbon,:forecast_impact_diversity,:forecast_impact_controversy,
             :historic_model_ex_market,:historic_model_ex_market_sector,:dynamic_model_ex_market,:dynamic_model_ex_market_sector

  def self.extract(batch)
    result = []

    parsed = JSON.parse(EsgRatingSerializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end  
end
