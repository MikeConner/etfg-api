# == Schema Information
#
# Table name: fund_flows
#
#  id               :bigint(8)        not null, primary key
#  run_date         :date             not null
#  as_of_date       :date
#  composite_ticker :string(12)       not null
#  shares           :decimal(14, 2)
#  nav              :decimal(14, 6)
#  value            :decimal(20, 6)
#

class FundFlowV2Serializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :as_of_date, :composite_ticker, :shares, :nav, :value 

  def self.extract(batch)
    result = []

    parsed = JSON.parse(FundFlowV2Serializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
