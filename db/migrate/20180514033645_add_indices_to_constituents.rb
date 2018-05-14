class AddIndicesToConstituents < ActiveRecord::Migration[5.2]
  def change
    add_index :constituents, [:run_date, :composite_ticker]
    add_index :constituents, :run_date
    add_index :constituents, :composite_ticker
    add_index :constituents, :cusip
    add_index :constituents, :isin
    add_index :constituents, :figi
    add_index :constituents, :sedol
  end
end
