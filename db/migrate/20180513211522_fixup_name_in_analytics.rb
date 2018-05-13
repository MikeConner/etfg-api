class FixupNameInAnalytics < ActiveRecord::Migration[5.2]
  def change
    rename_column :analytics, :quant_tota_score, :quant_total_score
  end
end
