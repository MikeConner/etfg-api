class InstrumentSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :instrument_id, :ticker, :exchange_country, :currency, :standard_name, :name_variants, 
             :figi, :is_exchange_figi, :sedol, :isin, :cusip, :secid, :cusip_validated,
             :exchange, :market_sector, :security_type, :sector, :industry, :industry_group, :subindustry, :rating,
             :geography, :asset_class, :datasource_id, :approved, :is_valid, :default_instrument, :notes
 
  def self.extract(batch)
    result = []

    parsed = JSON.parse(EsgInstrument.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
