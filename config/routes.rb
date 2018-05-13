Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Constituents
=begin
    $constituentCollection->setPrefix("/constituent");

    $constituentCollection->get('/cusip/{date}/{fund}/{id}', 'getByCusip');
    $constituentCollection->get('/cusip/{date}/{fund}', 'getByCusip');

    $constituentCollection->get('/isin/{date}/{fund}/{id}', 'getByIsin');
    $constituentCollection->get('/isin/{date}/{fund}', 'getByIsin');

    $constituentCollection->get('/sedol/{date}/{fund}/{id}', 'getBySedol');
    $constituentCollection->get('/sedol/{date}/{fund}', 'getBySedol');


    $constituentCollection->get('/figi/{date}/{fund}/{id}', 'getByFigi');
    $constituentCollection->get('/figi/{date}/{fund}', 'getByFigi');

    # Top constituents
    $topConstituentCollection->setPrefix("/topconstituents");

    $topConstituentCollection->get('/weight/{date}/{fund}', 'getTopConstituents');
    
    # ETP Data
    
    $etpdataCollection->setPrefix("/etpdata");

    $etpdataCollection->get('/{date}', 'getEtpData');
    $etpdataCollection->get('/', 'getEtpData');

    # Fund Flow

    $fundflowCollection->setPrefix("/fundflow");

    $fundflowCollection->get('/{date}/{fund}', 'getFundFlow');
    $fundflowCollection->get('/{date}', 'getFundFlow');

    # Industry

    $industryCollection->setPrefix("/industry");


    $industryCollection->get('/csv/{date}/{fund}', 'getIndustryCsv');
    $industryCollection->get('/csv/{date}', 'getIndustryCsv');
    $industryCollection->get('/exposures/{type}/{date}/{fund}', 'getIndustryExposures');
    $industryCollection->get('/{date}/{fund}', 'getIndustry');
    $industryCollection->get('/{date}', 'getIndustry');
    
=end  


  # Analytics
  # /analytics
  # $analyticsCollection->get('/{function}/{date}/{fund}/{group}', 'getAggregateFunction');
  # $analyticsCollection->get('/{date}/{fund}', 'getAnalytics');
  # $analyticsCollection->get('/{date}', 'getAnalytics');
  get '/analytics/:function/:date/:fund/:group/getAggregateFunction', to: 'analytics#aggregate'
  get '/analytics/:date/:fund/getAnalytics', to: 'analytics#by_fund'
  get '/analytics/:date/getAnalytics', to: 'analytics#by_date'
end
