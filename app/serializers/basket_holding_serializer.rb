# == Schema Information
#
# Table name: basket_holdings
#
#  id                 :bigint(8)        not null, primary key
#  run_date           :date             not null
#  as_of_date         :date
#  composite_ticker   :string(32)       not null
#  exchange_country   :string(16)       not null
#  composite_name     :string(128)
#  issuer             :string(32)
#  constituent_ticker :string(64)
#  constituent_name   :string(128)
#  cusip              :string(9)
#  figi               :string(12)
#  isin               :string(12)
#  sedol              :string(7)
#  market_value       :decimal(22, 6)
#  basket_weight      :decimal(18, 10)
#  holdings_weight    :decimal(18, 10)
#  weight_diff        :decimal(18, 10)
#  total_shares_held  :decimal(22, 6)
#  cash_in_lieu_flag  :boolean
#  new_security_flag  :boolean
#  output_region      :string(2)
#

class BasketHoldingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :run_date, :as_of_date, :composite_ticker, :exchange_country, :composite_name, :issuer, :constituent_ticker, 
             :constituent_name, :cusip, :figi, :isin, :sedol, :market_value, :basket_weight, :holdings_weight, :weight_diff, 
             :total_shares_held, :cash_in_lieu_flag, :new_security_flag

  def self.extract(batch)
    result = []

    parsed = JSON.parse(BasketHoldingSerializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
