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
      get 'products', :on => :collection
    end  
    
    resources :fundflows, :only => [:index, :show] do
      get 'products', :on => :collection
    end  
    
    resources :constituents, :only => [:show] do
      member do
        get 'contents'
        get 'top'
      end
      
      get 'products', :on => :collection
    end
    
    resources :users, :except => [:new, :edit]
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
  
  get '/api/topconstituents/weight/:date/:fund/getTopConstituents', to: 'v1/constituents#top'
  
  get '/api/constituent/:type/:date/:fund/:identifier/getByCusip', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/:identifier/getByIsin', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/:identifier/getByFigi', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/:identifier/getBySedol', to: 'v1/constituents#show'  

  # :type = cusip/isin/figi/sedol
  get '/api/constituent/:type/:date/:fund/getByCusip', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/getByIsin', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/getByFigi', to: 'v1/constituents#show'  
  get '/api/constituent/:type/:date/:fund/getBySedol', to: 'v1/constituents#show'  
  
  get '/api/fundflow/:date/:fund/getFundFlow', to: 'v1/fundflows#show'
  get '/api/fundflow/:date/getFundFlow', to: 'v1/fundflows#index'
  
  get '/api/industry/csv/:date/:fund/getIndustry', to: 'v1/industries#csv'
  get '/api/industry/csv/:date/getIndustry', to: 'v1/industries#csv'
  get '/api/industry/:date/:fund/getIndustry', to: 'v1/industries#show'
  get '/api/industry/:date/getIndustry', to: 'v1/industries#index'
  get '/api/industry/exposures/:type/:date/:fund/getIndustryExposures', to: 'v1/industries#exposures'
  
  # Analytics
  get '/api/analytics/:date/:fund/:group/:function/getAggregateFunction', to: 'v1/analytics#aggregate'
  get '/api/analytics/:date/:fund/getAnalytics', to: 'v1/analytics#show'
  get '/api/analytics/:date/getAnalytics', to: 'v1/analytics#index'
end
