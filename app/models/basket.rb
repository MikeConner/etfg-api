# == Schema Information
#
# Table name: baskets
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
#  creation_unit_size      :decimal(18, 6)
#  estimated_cash          :decimal(22, 6)
#  total_cash              :decimal(22, 6)
#  cash_in_lieu_value      :decimal(22, 6)
#  constituent_ticker      :string(64)
#  constituent_name        :string(128)
#  cusip                   :string(9)
#  figi                    :string(12)
#  isin                    :string(12)
#  sedol                   :string(7)
#  market_value            :decimal(22, 6)
#  basket_weight           :decimal(18, 10)
#  holdings_weight         :decimal(18, 10)
#  weight_diff             :decimal(18, 10)
#  total_shares_held       :decimal(22, 6)
#  cash_in_lieu_flag       :boolean
#  new_security_flag       :boolean
#  component_count         :integer
#  asset_class             :string(28)
#  category                :string(28)
#  development_class       :string(32)
#  focus                   :string(28)
#  expense_ratio           :decimal(18, 6)
#  aum                     :decimal(22, 6)
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

class Basket < EtfgDbV2Base
  self.record_timestamps = false

  validates_presence_of :run_date
  validates_length_of :composite_ticker, :maximum => 32
  validates_length_of :exchange_country, :maximum => 32
  validates_length_of :issuer, :development_class, :maximum => 32, :allow_nil => true
  validates_length_of :composite_cusip, :cusip, :is => 9, :allow_nil => true
  validates_length_of :composite_isin, :isin, :figi, :is => 12, :allow_nil => true
  validates_length_of :sedol, :is => 9, :allow_nil => true
  validates_numericality_of :creation_unit_size, :estimated_cash, :total_cash, :cash_in_lieu_value,
                            :market_value, :basket_weight, :holdings_weight, :weight_diff, :total_shares_held,
                            :expense_ratio, :aum, :nav, :shares_outstanding, :reward_score, :risk_total_score,
                            :allow_nil => true
  validates_numericality_of :component_count, :only_integer => true, :allow_nil => true
  validates_length_of :asset_class, :category, :focus, :maximum => 28, :allow_nil => true
  validates_inclusion_of :cash_in_lieu_flag, :new_security_flag, :in => [true, false], :allow_nil => true
end
