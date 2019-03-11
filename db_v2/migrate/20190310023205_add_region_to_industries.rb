class AddRegionToIndustries < Apiv2MigrationBase[5.2]
  def change
    add_column :industries, :output_region, 'character(2)'
  end
end
