Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :api_base do
    resources :analytics, :only => [:index, :show] do
      get 'aggregate', :on => :member
      get 'products', :on => :collection
    end
    
    resources :industries, :only => [:index, :show] do
      get 'exposures', :on => :member
    end    
  end

  namespace :v1 do
    concerns :api_base
  end
    
  # Constituents
=begin
    # ETP Data - Skipping
    
    $etpdataCollection->setPrefix("/etpdata");

    $etpdataCollection->get('/{date}', 'getEtpData');
    $etpdataCollection->get('/', 'getEtpData');
    
=end  

  # Legacy routes
  
  get '/api/topconstituents/weight/:date/:fund/getTopConstituents', to: 'constituents#top'
  get '/api/constituent/cusip/:date/:fund/:id/getByCusip', to: 'constituents#by_cusip_id'  
  get '/api/constituent/isin/:date/:fund/:id/getByIsin', to: 'constituents#by_isin_id'  
  get '/api/constituent/figi/:date/:fund/:id/getByFigi', to: 'constituents#by_figi_id'  
  get '/api/constituent/sedol/:date/:fund/:id/getBySedol', to: 'constituents#by_sedol_id'  

  # These are exactly equivalent, unless I don't understand something?
  get '/api/constituent/cusip/:date/:fund/getByCusip', to: 'constituents#by_cusip'  
  get '/api/constituent/isin/:date/:fund/getByIsin', to: 'constituents#by_isin'  
  get '/api/constituent/figi/:date/:fund/getByFigi', to: 'constituents#by_figi'  
  get '/api/constituent/sedol/:date/:fund/getBySedol', to: 'constituents#by_sedol'  
  
  get '/api/fundflow/:date/:fund/getFundFlow', to: 'fund_flows#by_fund'
  get '/api/fundflow/:date/getFundFlow', to: 'fund_flows#by_date'
  
  get '/api/industry/csv/:date/:fund/getIndustry', to: 'industries#csv_by_fund'
  get '/api/industry/csv/:date/getIndustry', to: 'industries#csv_by_date'
  get '/api/industry/:date/:fund/getIndustry', to: 'industries#by_fund'
  get '/api/industry/:date/getIndustry', to: 'industries#by_date'
  get '/api/industry/exposures/:type/:date/:fund/getIndustryExposures', to: 'industries#legacy_exposures'
  
  # Analytics
  get '/api/analytics/:date/:fund/:group/:function/getAggregateFunction', to: 'v1/analytics#aggregate'
  get '/api/analytics/:date/:fund/getAnalytics', to: 'v1/analytics#show'
  get '/api/analytics/:date/getAnalytics', to: 'v1/analytics#index'
end
