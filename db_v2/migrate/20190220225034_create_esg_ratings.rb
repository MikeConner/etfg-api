class CreateEsgRatings < Apiv2MigrationBase[5.2]
  def change
    create_table :esg_ratings do |t|
      t.date :etfg_date
      t.date :rating_date
      t.string :composite_ticker
      t.decimal :e1, :precision => 22, :scale => 6
      t.decimal :e2, :precision => 22, :scale => 6
      t.decimal :e3, :precision => 22, :scale => 6
      t.decimal :emp1, :precision => 22, :scale => 6
      t.decimal :emp2, :precision => 22, :scale => 6
      t.decimal :emp3, :precision => 22, :scale => 6
      t.decimal :cit1, :precision => 22, :scale => 6
      t.decimal :cit2, :precision => 22, :scale => 6
      t.decimal :cit3, :precision => 22, :scale => 6
      t.decimal :g1, :precision => 22, :scale => 6
      t.decimal :g2, :precision => 22, :scale => 6
      t.decimal :g3, :precision => 22, :scale => 6
      t.decimal :e, :precision => 22, :scale => 6
      t.decimal :s, :precision => 22, :scale => 6
      t.decimal :g, :precision => 22, :scale => 6
      t.decimal :carbon, :precision => 22, :scale => 6
      t.decimal :diversity, :precision => 22, :scale => 6
      t.decimal :controversy, :precision => 22, :scale => 6      
      t.decimal :percentile_us_e1, :precision => 22, :scale => 6
      t.decimal :percentile_us_e2, :precision => 22, :scale => 6
      t.decimal :percentile_us_e3, :precision => 22, :scale => 6
      t.decimal :percentile_us_emp1, :precision => 22, :scale => 6
      t.decimal :percentile_us_emp2, :precision => 22, :scale => 6
      t.decimal :percentile_us_emp3, :precision => 22, :scale => 6
      t.decimal :percentile_us_cit1, :precision => 22, :scale => 6
      t.decimal :percentile_us_cit2, :precision => 22, :scale => 6
      t.decimal :percentile_us_cit3, :precision => 22, :scale => 6
      t.decimal :percentile_us_g1, :precision => 22, :scale => 6
      t.decimal :percentile_us_g2, :precision => 22, :scale => 6
      t.decimal :percentile_us_g3, :precision => 22, :scale => 6
      t.decimal :percentile_us_e, :precision => 22, :scale => 6
      t.decimal :percentile_us_s, :precision => 22, :scale => 6
      t.decimal :percentile_us_g, :precision => 22, :scale => 6
      t.decimal :percentile_us_esg, :precision => 22, :scale => 6
      t.decimal :percentile_us_carbon, :precision => 22, :scale => 6
      t.decimal :percentile_us_diversity, :precision => 22, :scale => 6
      t.decimal :percentile_us_controversy, :precision => 22, :scale => 6      
      t.decimal :quantile_us_e1, :precision => 22, :scale => 6
      t.decimal :quantile_us_e2, :precision => 22, :scale => 6
      t.decimal :quantile_us_e3, :precision => 22, :scale => 6
      t.decimal :quantile_us_emp1, :precision => 22, :scale => 6
      t.decimal :quantile_us_emp2, :precision => 22, :scale => 6
      t.decimal :quantile_us_emp3, :precision => 22, :scale => 6
      t.decimal :quantile_us_cit1, :precision => 22, :scale => 6
      t.decimal :quantile_us_cit2, :precision => 22, :scale => 6
      t.decimal :quantile_us_cit3, :precision => 22, :scale => 6
      t.decimal :quantile_us_g1, :precision => 22, :scale => 6
      t.decimal :quantile_us_g2, :precision => 22, :scale => 6
      t.decimal :quantile_us_g3, :precision => 22, :scale => 6
      t.decimal :quantile_us_e, :precision => 22, :scale => 6
      t.decimal :quantile_us_s, :precision => 22, :scale => 6
      t.decimal :quantile_us_g, :precision => 22, :scale => 6
      t.decimal :quantile_us_esg, :precision => 22, :scale => 6
      t.decimal :quantile_us_carbon, :precision => 22, :scale => 6
      t.decimal :quantile_us_diversity, :precision => 22, :scale => 6
      t.decimal :quantile_us_controversy, :precision => 22, :scale => 6
      t.decimal :forecast_impact_e1, :precision => 22, :scale => 6
      t.decimal :forecast_impact_e2, :precision => 22, :scale => 6
      t.decimal :forecast_impact_e3, :precision => 22, :scale => 6
      t.decimal :forecast_impact_emp1, :precision => 22, :scale => 6
      t.decimal :forecast_impact_emp2, :precision => 22, :scale => 6
      t.decimal :forecast_impact_emp3, :precision => 22, :scale => 6
      t.decimal :forecast_impact_cit1, :precision => 22, :scale => 6
      t.decimal :forecast_impact_cit2, :precision => 22, :scale => 6
      t.decimal :forecast_impact_cit3, :precision => 22, :scale => 6
      t.decimal :forecast_impact_g1, :precision => 22, :scale => 6
      t.decimal :forecast_impact_g2, :precision => 22, :scale => 6
      t.decimal :forecast_impact_g3, :precision => 22, :scale => 6
      t.decimal :forecast_impact_e, :precision => 22, :scale => 6
      t.decimal :forecast_impact_s, :precision => 22, :scale => 6
      t.decimal :forecast_impact_g, :precision => 22, :scale => 6
      t.decimal :forecast_impact_esg, :precision => 22, :scale => 6
      t.decimal :forecast_impact_carbon, :precision => 22, :scale => 6
      t.decimal :forecast_impact_diversity, :precision => 22, :scale => 6
      t.decimal :forecast_impact_controversy, :precision => 22, :scale => 6
      t.decimal :historic_model_ex_market, :precision => 22, :scale => 6
      t.decimal :historic_model_ex_market_sector, :precision => 22, :scale => 6
      t.decimal :dynamic_model_ex_market, :precision => 22, :scale => 6
      t.decimal :dynamic_model_ex_market_sector, :precision => 22, :scale => 6
    end
  end
end
