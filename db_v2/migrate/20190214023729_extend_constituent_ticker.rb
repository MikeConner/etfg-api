class ExtendConstituentTicker < Apiv2MigrationBase[5.2]
  def up
    change_column :constituents, :identifier, :string, :limit => 64
  end
  
  def down
    change_column :constituents, :identifier, :string, :limit => 32    
  end
end
