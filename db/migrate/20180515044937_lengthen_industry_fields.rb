class LengthenIndustryFields < ActiveRecord::Migration[5.2]
  def change
    change_column :industries, :issuer, :string, :limit => 64
    change_column :industries, :related_index, :string
    change_column :industries, :tax_classification, :string, :limit => 64
  end
end
