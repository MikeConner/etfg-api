class EtfgDbBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection ETFG_DB
end  
