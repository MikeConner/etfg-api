# == Schema Information
#
# Table name: constituents
#
#  id                :bigint(8)        not null, primary key
#  run_date          :date             not null
#  as_of_date        :date
#  composite_ticker  :string(12)       not null
#  identifier        :string(32)
#  constituent_name  :string
#  weight            :decimal(10, 6)
#  market_value      :decimal(20, 6)
#  cusip             :string(24)
#  isin              :string(16)
#  figi              :string(16)
#  sedol             :string(16)
#  country           :string(32)
#  exchange          :string(64)
#  total_shares_held :decimal(18, 4)
#  market_sector     :string(128)
#  security_type     :string(128)
#  currency          :string(16)
#

class ConstituentV2Serializer
  include FastJsonapi::ObjectSerializer
  
  attributes :run_date, :as_of_date, :composite_ticker, :identifier, :constituent_name, :weight, :market_value, :cusip, :isin, :figi, :sedol,
             :country, :exchange, :total_shares_held, :market_sector, :security_type, :currency

  def self.extract(batch)
    result = []

    parsed = JSON.parse(ConstituentV2Serializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
