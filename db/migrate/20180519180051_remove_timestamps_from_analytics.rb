class RemoveTimestampsFromAnalytics < ActiveRecord::Migration[5.2]
  def up
    drop_table :analytics
    
    #create_table :analytics, :id => false, :primary_key => %i[run_date composite_ticker] do |t|
    create_table :analytics do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.decimal :risk_total_score, :precision => 16, :scale => 4
      t.decimal :risk_volatility, :precision => 16, :scale => 4
      t.decimal :risk_deviation, :precision => 16, :scale => 4
      t.decimal :risk_country, :precision => 16, :scale => 4
      t.decimal :risk_structure, :precision => 16, :scale => 4
      t.decimal :risk_liquidity, :precision => 16, :scale => 4
      t.decimal :risk_efficiency, :precision => 16, :scale => 4
      t.decimal :reward_score, :precision => 16, :scale => 4
      t.decimal :quant_total_score, :precision => 16, :scale => 4
      t.decimal :quant_technical_st, :precision => 16, :scale => 4
      t.decimal :quant_technical_it, :precision => 16, :scale => 4
      t.decimal :quant_technical_lt, :precision => 16, :scale => 4
      t.decimal :quant_composite_technical, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_pc, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_si, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_iv, :precision => 16, :scale => 4
      t.decimal :quant_composite_sentiment, :precision => 16, :scale => 4
      t.decimal :quant_composite_behavioral, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pe, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pcf, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pb, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_div, :precision => 16, :scale => 4
      t.decimal :quant_composite_fundamental, :precision => 16, :scale => 4
      t.decimal :quant_global_sector, :precision => 16, :scale => 4
      t.decimal :quant_global_country, :precision => 16, :scale => 4
      t.decimal :quant_composite_global, :precision => 16, :scale => 4
      t.decimal :quant_quality_liquidity, :precision => 16, :scale => 4
      t.decimal :quant_quality_diversification, :precision => 16, :scale => 4
      t.decimal :quant_quality_firm, :precision => 16, :scale => 4
      t.decimal :quant_composite_quality, :precision => 16, :scale => 4
      t.string :quant_grade, :limit => 1
    end
    
    add_index :analytics, [:run_date, :composite_ticker], :unique => true
    add_index :analytics, :run_date
    add_index :analytics, :composite_ticker
  end
  
  def down
    drop_table :analytics

    create_table :analytics do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.decimal :risk_total_score, :precision => 16, :scale => 4
      t.decimal :risk_volatility, :precision => 16, :scale => 4
      t.decimal :risk_deviation, :precision => 16, :scale => 4
      t.decimal :risk_country, :precision => 16, :scale => 4
      t.decimal :risk_structure, :precision => 16, :scale => 4
      t.decimal :risk_liquidity, :precision => 16, :scale => 4
      t.decimal :risk_efficiency, :precision => 16, :scale => 4
      t.decimal :reward_score, :precision => 16, :scale => 4
      t.decimal :quant_total_score, :precision => 16, :scale => 4
      t.decimal :quant_technical_st, :precision => 16, :scale => 4
      t.decimal :quant_technical_it, :precision => 16, :scale => 4
      t.decimal :quant_technical_lt, :precision => 16, :scale => 4
      t.decimal :quant_composite_technical, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_pc, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_si, :precision => 16, :scale => 4
      t.decimal :quant_sentiment_iv, :precision => 16, :scale => 4
      t.decimal :quant_composite_sentiment, :precision => 16, :scale => 4
      t.decimal :quant_composite_behavioral, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pe, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pcf, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_pb, :precision => 16, :scale => 4
      t.decimal :quant_fundamental_div, :precision => 16, :scale => 4
      t.decimal :quant_composite_fundamental, :precision => 16, :scale => 4
      t.decimal :quant_global_sector, :precision => 16, :scale => 4
      t.decimal :quant_global_country, :precision => 16, :scale => 4
      t.decimal :quant_composite_global, :precision => 16, :scale => 4
      t.decimal :quant_quality_liquidity, :precision => 16, :scale => 4
      t.decimal :quant_quality_diversification, :precision => 16, :scale => 4
      t.decimal :quant_quality_firm, :precision => 16, :scale => 4
      t.decimal :quant_composite_quality, :precision => 16, :scale => 4
      t.string :quant_grade, :limit => 1
      
      t.timestamps
    end    

    add_index :analytics, [:run_date, :composite_ticker], :unique => true
    add_index :analytics, :run_date
    add_index :analytics, :composite_ticker
  end
end
