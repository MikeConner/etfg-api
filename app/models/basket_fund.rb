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

class BasketFund < EtfgDbV2Base
  self.record_timestamps = false

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 32
  validates_length_of :exchange_country, :maximum => 16, :allow_nil => true
  validates_length_of :composite_name, :maximum => 128, :allow_nil => true
  validates_length_of :output_region, :is => 2
  validates_length_of :issuer, :development_class, :maximum => 32, :allow_nil => true
  validates_length_of :composite_cusip, :is => 9, :allow_nil => true
  validates_length_of :composite_isin, :is => 12, :allow_nil => true
  validates_numericality_of :creation_fee, :creation_unit_size, :estimated_cash_cu, :estimated_cash_etf, :total_cash,
                            :dividend_per_etf, :expense_ratio, :aum, :nav, :shares_outstanding, :reward_score,
                            :risk_total_score, :nav_per_cu, :cash_in_lieu_value, :allow_nil => true
  validates_numericality_of :component_count, :only_integer => true, :allow_nil => true
  validates_length_of :asset_class, :category, :focus, :maximum => 28, :allow_nil => true
end
