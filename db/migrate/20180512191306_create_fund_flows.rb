class CreateFundFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :fund_flows do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.decimal :shares, :precision => 14, :scale => 2
      t.decimal :nav, :precision => 14, :scale => 6
      t.decimal :value, :precision => 20, :scale => 6

      t.timestamps
    end
  end
end
