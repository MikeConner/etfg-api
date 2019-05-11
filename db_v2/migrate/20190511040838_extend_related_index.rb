class ExtendRelatedIndex < Apiv2MigrationBase[5.2]
  def up
    change_column :industries, :related_index, :string
  end
  
  def down
    change_column :industries, :related_index, :string, :limit => 128    
  end
end
