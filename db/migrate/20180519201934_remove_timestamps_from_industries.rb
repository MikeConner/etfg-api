class RemoveTimestampsFromIndustries < ActiveRecord::Migration[5.2]
  def up
    drop_table :industries

    #create_table :industries, :id => false, :primary_key => %i[run_date composite_ticker] do |t|
    create_table :industries do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :null => false
      t.string :issuer, :limit => 32
      t.string :name, :limit => 128
      t.date :inception_date
      t.string :related_index, :limit => 128
      t.string :tax_classification, :limit => 32
      t.boolean :is_etn
      t.decimal :fund_aum, :precision => 24, :scale => 6
      t.string :avg_volume, :limit => 10
      t.string :asset_class, :limit => 32
      t.string :category, :limit => 32
      t.string :focus, :limit => 32
      t.string :development_level, :limit => 32
      t.string :region, :limit => 32
      t.boolean :is_leveraged
      t.string :leverage_factor, :limit => 16
      t.boolean :active
      t.string :administrator, :limit => 64
      t.string :advisor, :limit => 64
      t.string :custodian, :limit => 128
      t.string :distributor, :limit => 128
      t.string :portfolio_manager
      t.string :subadvisor, :limit => 128
      t.string :transfer_agent, :limit => 64
      t.string :trustee, :limit => 64
      t.string :futures_commission_merchant, :limit => 128
      t.string :fiscal_year_end, :limit => 16
      t.string :distribution_frequency, :limit => 1
      t.string :listing_exchange, :limit => 64
      t.decimal :creation_unit_size, :precision => 12, :scale => 0
      t.decimal :creation_fee, :precision => 8, :scale => 0
      t.text :geographic_exposure
      t.text :currency_exposure      
      t.text :sector_exposure
      t.text :industry_group_exposure
      t.text :industry_exposure
      t.text :subindustry_exposure
      t.text :coupon_exposure
      t.text :maturity_exposure
      t.boolean :option_available
      t.string :option_volume, :limit => 16
      t.decimal :short_interest, :precision => 12, :scale => 0
      t.string :put_call_ratio, :limit => 32
      t.decimal :num_constituents, :precision => 6, :scale => 0
      t.decimal :discount_premium, :precision => 8, :scale => 2
      t.decimal :bid_ask_spread, :precision => 16, :scale => 12
      t.string :put_vol, :limit => 14
      t.string :call_vol, :limit => 14
      t.decimal :management_fee, :precision => 12, :scale => 4
      t.decimal :other_expenses, :precision => 12, :scale => 4
      t.decimal :total_expenses, :precision => 12, :scale => 4
      t.decimal :fee_waivers, :precision => 12, :scale => 4
      t.decimal :net_expenses, :precision => 12, :scale => 4
      t.string :lead_market_maker, :limit => 64
    end   
     
    add_index :industries, [:run_date, :composite_ticker], :unique => true
    add_index :industries, :run_date
    add_index :industries, :composite_ticker
  end
  
  def down
    drop_table :industries
    
    create_table :industries do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :null => false
      t.string :issuer, :limit => 32
      t.string :name, :limit => 128
      t.date :inception_date
      t.string :related_index, :limit => 128
      t.string :tax_classification, :limit => 32
      t.boolean :is_etn
      t.decimal :fund_aum, :precision => 24, :scale => 6
      t.string :avg_volume, :limit => 10
      t.string :asset_class, :limit => 32
      t.string :category, :limit => 32
      t.string :focus, :limit => 32
      t.string :development_level, :limit => 32
      t.string :region, :limit => 32
      t.boolean :is_leveraged
      t.string :leverage_factor, :limit => 16
      t.boolean :active
      t.string :administrator, :limit => 64
      t.string :advisor, :limit => 64
      t.string :custodian, :limit => 128
      t.string :distributor, :limit => 128
      t.string :portfolio_manager
      t.string :subadvisor, :limit => 128
      t.string :transfer_agent, :limit => 64
      t.string :trustee, :limit => 64
      t.string :futures_commission_merchant, :limit => 128
      t.string :fiscal_year_end, :limit => 16
      t.string :distribution_frequency, :limit => 1
      t.string :listing_exchange, :limit => 64
      t.decimal :creation_unit_size, :precision => 12, :scale => 0
      t.decimal :creation_fee, :precision => 8, :scale => 0
      t.text :geographic_exposure
      t.text :currency_exposure      
      t.text :sector_exposure
      t.text :industry_group_exposure
      t.text :industry_exposure
      t.text :subindustry_exposure
      t.text :coupon_exposure
      t.text :maturity_exposure
      t.boolean :option_available
      t.string :option_volume, :limit => 16
      t.decimal :short_interest, :precision => 12, :scale => 0
      t.string :put_call_ratio, :limit => 32
      t.decimal :num_constituents, :precision => 6, :scale => 0
      t.decimal :discount_premium, :precision => 8, :scale => 2
      t.decimal :bid_ask_spread, :precision => 16, :scale => 12
      t.string :put_vol, :limit => 14
      t.string :call_vol, :limit => 14
      t.decimal :management_fee, :precision => 12, :scale => 4
      t.decimal :other_expenses, :precision => 12, :scale => 4
      t.decimal :total_expenses, :precision => 12, :scale => 4
      t.decimal :fee_waivers, :precision => 12, :scale => 4
      t.decimal :net_expenses, :precision => 12, :scale => 4
      t.string :lead_market_maker, :limit => 64

      t.timestamps
    end

    add_index :industries, [:run_date, :composite_ticker], :unique => true
    add_index :industries, :run_date
    add_index :industries, :composite_ticker
  end
end
