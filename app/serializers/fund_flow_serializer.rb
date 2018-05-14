class FundFlowSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :composite_ticker, :shares, :nav, :value 

  def self.extract(batch)
    result = []

    parsed = JSON.parse(FundFlowSerializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
