# == Schema Information
#
# Table name: basket_funds
#
#  id                      :bigint(8)        not null, primary key
#  run_date                :date             not null
#  as_of_date              :date
#  composite_ticker        :string(32)       not null
#  exchange_country        :string(16)       not null
#  composite_name          :string(128)
#  issuer                  :string(32)
#  composite_cusip         :string(9)
#  composite_isin          :string(12)
#  creation_fee            :decimal(18, 6)
#  creation_unit_size      :decimal(18, 6)
#  cash_only_flag          :boolean
#  estimated_cash_cu       :decimal(22, 6)
#  estimated_cash_etf      :decimal(22, 6)
#  total_cash              :decimal(22, 6)
#  cash_in_lieu_value      :decimal(22, 6)
#  dividend_per_etf        :decimal(22, 6)
#  component_count         :integer
#  asset_class             :string(28)
#  category                :string(28)
#  development_class       :string(32)
#  focus                   :string(28)
#  expense_ratio           :decimal(18, 6)
#  aum                     :decimal(22, 6)
#  nav_per_cu              :decimal(22, 6)
#  nav                     :decimal(22, 6)
#  shares_outstanding      :decimal(22, 6)
#  geographic_exposure     :text
#  sector_exposure         :text
#  industry_exposure       :text
#  industry_group_exposure :text
#  subindustry_exposure    :text
#  reward_score            :decimal(16, 4)
#  risk_total_score        :decimal(16, 4)
#  output_region           :string(2)
#

class BasketFundSerializer
  include FastJsonapi::ObjectSerializer

  attributes :run_date, :as_of_date, :composite_ticker, :exchange_country, :composite_name, :issuer, :composite_cusip, :composite_isin, 
             :creation_fee, :creation_unit_size, :cash_only_flag, :estimated_cash_cu, :estimated_cash_etf, :total_cash, :cash_in_lieu_value, 
             :dividend_per_etf, :component_count, :asset_class, :category, :development_class, :focus, :expense_ratio, :aum, :nav_per_cu,
             :nav, :shares_outstanding, :geographic_exposure, :sector_exposure, :industry_exposure, :industry_group_exposure, 
             :subindustry_exposure, :reward_score, :risk_total_score

  def self.extract(batch)
    result = []

    parsed = JSON.parse(BasketFundSerializer.new(batch).serialized_json)['data']
    parsed.each do |a|
      result.push(a['attributes'])
    end   
    
    result     
  end
end
