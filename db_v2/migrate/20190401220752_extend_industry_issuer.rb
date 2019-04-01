class ExtendIndustryIssuer < Apiv2MigrationBase[5.2]
  def up
    change_column :industries, :issuer, :string, :limit => 64
  end
  
  def down
    change_column :industries, :issuer, :string, :limit => 32    
  end
end
