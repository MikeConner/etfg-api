Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Constituents
=begin
    # ETP Data - Skipping
    
    $etpdataCollection->setPrefix("/etpdata");

    $etpdataCollection->get('/{date}', 'getEtpData');
    $etpdataCollection->get('/', 'getEtpData');
    
=end  

  get '/topconstituents/weight/:date/:fund/getTopConstituents', to: 'constituents#top'
  get '/constituent/cusip/:date/:fund/:id/getByCusip', to: 'constituents#by_cusip_id'  
  get '/constituent/isin/:date/:fund/:id/getByIsin', to: 'constituents#by_isin_id'  
  get '/constituent/figi/:date/:fund/:id/getByFigi', to: 'constituents#by_figi_id'  
  get '/constituent/sedol/:date/:fund/:id/getBySedol', to: 'constituents#by_sedol_id'  

  # These are exactly equivalent, unless I don't understand something?
  get '/constituent/cusip/:date/:fund/getByCusip', to: 'constituents#by_cusip'  
  get '/constituent/isin/:date/:fund/getByIsin', to: 'constituents#by_isin'  
  get '/constituent/figi/:date/:fund/getByFigi', to: 'constituents#by_figi'  
  get '/constituent/sedol/:date/:fund/getBySedol', to: 'constituents#by_sedol'  
  
  get '/fundflow/:date/:fund/getFundFlow', to: 'fund_flows#by_fund'
  get '/fundflow/:date/getFundFlow', to: 'fund_flows#by_date'
  
  get '/industry/csv/:date/:fund/getIndustry', to: 'industries#csv_by_fund'
  get '/industry/csv/:date/getIndustry', to: 'industries#csv_by_date'
  get '/industry/:date/:fund/getIndustry', to: 'industries#by_fund'
  get '/industry/:date/getIndustry', to: 'industries#by_date'
  get '/industry/exposures/:type/:date/:fund/getIndustryExposures', to: 'industries#exposures'
  
  # Analytics
  get '/analytics/:function/:date/:fund/:group/getAggregateFunction', to: 'analytics#aggregate'
  get '/analytics/:date/:fund/getAnalytics', to: 'analytics#by_fund'
  get '/analytics/:date/getAnalytics', to: 'analytics#by_date'
end
