class EtfgDbV2Base < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection ETFG_V2_DB
end  
