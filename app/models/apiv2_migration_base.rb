class Apiv2MigrationBase < ActiveRecord::Migration[5.2] 
  def connection
    EtfgDbV2Base.connection
  end
end
