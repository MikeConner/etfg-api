# == Schema Information
#
# Table name: fund_flows
#
#  id               :bigint(8)        not null, primary key
#  run_date         :date             not null
#  composite_ticker :string(8)        not null
#  shares           :decimal(14, 2)
#  nav              :decimal(14, 6)
#  value            :decimal(20, 6)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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
