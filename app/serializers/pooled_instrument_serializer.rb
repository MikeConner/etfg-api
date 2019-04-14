class PooledInstrumentSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :pooled_instrument_id, :region, :composite_ticker, :exchange_country, :standard_composite_name, :composite_name_variants,
             :composite_description, :issuer, :is_index, :is_active, :is_etn, :is_levered, :is_inverse, :has_derivatives, :options_available, 
             :inception_date, :etp_structure_type, :category, :related_index_symbol, :net_expenses, :expense_ratio, :listing_exchange, 
             :asset_class, :development_class, :focus, :lead_market_maker, :levered_amount, :maturity_date, :exposure_country, 
             :selection_criteria, :weighting_scheme, :administrator, :advisor, :distributor, :fee_waivers, :fiscal_year_end, 
             :futures_commission_merchant, :subadvisor, :tax_classification, :transfer_agent, :trustee, :creation_fee, :creation_unit_size, 
             :custodian, :distribution_frequency, :management_fee, :portfolio_manager, :primary_benchmark, :total_expenses, :other_expenses, 
             :approved, :figi, :is_exchange_figi, :sedol, :isin, :cusip, :secid, :datasource_id

 
  def self.extract(batch)
    result = []

    parsed = JSON.parse(PooledInstrument.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
