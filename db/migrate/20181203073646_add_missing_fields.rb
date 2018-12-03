class AddMissingFields < ActiveRecord::Migration[5.2]
  # Sync up database fields with 10.10.10.10
  def change
    add_column :analytics, :as_of_date, :date
    add_column :constituents, :as_of_date, :date
    add_column :constituents, :currency, :string, limit: 16
    add_column :fund_flows, :as_of_date, :date
    add_column :industries, :as_of_date, :date
  end
end
