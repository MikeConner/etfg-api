require 'core_ext/nil'
require 'core_ext/string'
require 'csv'

if 0 == User.count
  current_users = <<-EOT
      icefeed:$apr1$IyzJeZia$mrfu6We5Z3F8dRtEK5IB90
      icedata:$apr1$ZbNX54wV$B7J4R9ccuUw6HOALa7uAR0
      icesignal:$apr1$miYKUfgH$3qh1x3ja1ABuXyhYONnXt/
      icebedge:$apr1$vM6jt0Kg$xOzs5ih2Z1uLxawHQWG990
      quantopian:$apr1$us/QoGbi$WUZUR3bH3fnV/u4edlwxw1
      etfg_mapper:$apr1$7pfRu3jD$3yFvKR7YgITWP2Js1SpHe0
      bob:$apr1$eddeA5Bw$VTuHNAJpeckAH4e6fDlQs.
      etpdata:$apr1$CQp6erL/$.QkfHuDMeJHT19b.WCr571
      CloudQuote:$apr1$Kzx4mnlT$B9siLIVK9Io85G.6QB/.l/
      ensofinancial:$apr1$gyq4UxJN$bOxaYQgiPOZNh7ayd8ljW.
      htdonline:$apr1$RJf8EGRI$OhLAP/d3k.lAuVQJcowWw0
      pdtpartners:$apr1$vG8azcVC$JFSaGrkH2Etu0xx86OFeD1
      steadfastcap:$apr1$O39VpAsY$gcEH6cNVVsW5eq6OhnVm0.
      fintechstudio:$apr1$oJUpvVEC$laeGomztKPbow9Cvk9tmF0
      lsi_user:$apr1$wgsYgH8H$ShOohD7fAauSi4it6ha5V.
      istra:$apr1$1IuJlPy1$3bVaqVRypbSLvBAnlDOJh/
      etfg_direct:$apr1$YN.LvBn6$4qNGZF4vSQwe16nnCbQ.40
      bwater:$apr1$L5PJwefr$QT9sW4BbmfTZ1V2X3dmw41
      wellington:$apr1$WUZZEPW7$RWIm/XulHmj6sZxLAgcph1
      wquant:$apr1$R1Ziu6cD$iKWw0EuwG4vA9.vWP1CZr/
      wallachbeth:$apr1$PmLeH4mn$suf86WxWAR1VJWFQDq8dm/
      fidopb:$apr1$QlBAfk2h$ZWAQqnHtRAcs2x.FCyv5m.
      creditsdone:$apr1$4mYoi6jf$hjlCjmaF4M2izLcO3D7l0.
      koyfin:$apr1$KXwTkpNw$NS.YrZ0o5KSUsBK10prMp1
      dbetfsales:$apr1$mcKLzCeJ$1wMRgyz1XEh5RsbHeKZbh1
      bodhitree:$apr1$MaElUxTc$7xYyZK6F3eADjQQLpFU1Y1  
    EOT
    
  current_users.split.each do |u|
    creds = u.split(':')
    raise 'Invalid split' unless 2 == creds.count
    
    u = User.create!(:username => creds[0], :password => 'password')
    u.update_attribute(:encrypted_password, creds[1])
  end
  
  User.create!(:username => 'test', :password => 'password')
end

if 0 == Industry.count
  fname = '2017-03-31_industry.csv'
  idx = 1
  CSV.foreach(fname) do |row|
    rec = Industry.new(:run_date => (Date.strptime(row[0], "%m/%d/%Y") rescue nil),
                       :composite_ticker => row[1],
                       :issuer => row[2],
                       :name => row[3],
                       :inception_date => (Date.parse(row[4]) rescue nil),
                       :related_index => row[5],
                       :tax_classification => row[6],
                       :is_etn => row[7].nullable_to_boolean,
                       :fund_aum => row[8].nullable_to_f,
                       :avg_volume => row[9],
                       :asset_class => row[10],
                       :category => row[11],
                       :focus => row[12],
                       :development_level => row[13],
                       :region => row[14],
                       :is_leveraged => row[15].nullable_to_boolean,
                       :leverage_factor => row[16],
                       :active => row[17].nullable_to_boolean,
                       :administrator => row[18],
                       :advisor => row[19],
                       :custodian => row[20],
                       :distributor => row[21],
                       :portfolio_manager => row[22],
                       :subadvisor => row[23],
                       :transfer_agent => row[24],
                       :trustee => row[25],
                       :futures_commission_merchant => row[26],
                       :fiscal_year_end => row[27],
                       :distribution_frequency => row[28],
                       :listing_exchange => row[29],
                       :creation_unit_size => row[30].nullable_to_f,
                       :creation_fee => row[31].nullable_to_f,
                       :geographic_exposure => row[32],
                       :currency_exposure => row[33],
                       :sector_exposure => row[34],
                       :industry_group_exposure => row[35],
                       :industry_exposure => row[36],
                       :subindustry_exposure => row[37],
                       :coupon_exposure => row[38],
                       :maturity_exposure => row[39],
                       :option_available => row[40].nullable_to_boolean,
                       :option_volume => row[41],
                       :short_interest => row[42].nullable_to_f,
                       :put_call_ratio => row[43],
                       :num_constituents => row[44].nullable_to_f,
                       :discount_premium => row[45].nullable_to_f,
                       :bid_ask_spread => row[46].nullable_to_f,
                       :put_vol => row[47],
                       :call_vol => row[48],
                       :management_fee => row[49].nullable_to_f,
                       :other_expenses => row[50].nullable_to_f,
                       :total_expenses => row[51].nullable_to_f,
                       :fee_waivers => row[52].nullable_to_f,
                       :net_expenses => row[53].nullable_to_f,
                       :lead_market_maker => row[54])
    if rec.valid?
      rec.save!
    else
      puts "#{fname}: line #{idx}\n#{row}\n#{rec.errors.full_messages.to_sentence}"
      break
    end
    
    idx += 1
  end  
end

if 0 == Analytic.count
  fname = '2018-05-09_analytics.csv'
  idx = 1
  CSV.foreach(fname) do |row|
    rec = Analytic.new(:run_date => (Date.parse(row[0]) rescue nil),
                       :composite_ticker => row[1],
                       :risk_total_score => row[2].nullable_to_f,
                       :risk_volatility => row[3].nullable_to_f,
                       :risk_deviation => row[4].nullable_to_f,
                       :risk_country => row[5].nullable_to_f,
                       :risk_structure => row[6].nullable_to_f,
                       :risk_liquidity => row[7].nullable_to_f,
                       :risk_efficiency => row[8].nullable_to_f,
                       :reward_score => row[9].nullable_to_f,
                       :quant_total_score => row[10].nullable_to_f,
                       :quant_technical_st => row[11].nullable_to_f,
                       :quant_technical_it => row[12].nullable_to_f,
                       :quant_technical_lt => row[13].nullable_to_f,
                       :quant_composite_technical => row[14].nullable_to_f,
                       :quant_sentiment_pc => row[15].nullable_to_f,
                       :quant_sentiment_si => row[16].nullable_to_f,
                       :quant_sentiment_iv => row[17].nullable_to_f,
                       :quant_composite_sentiment => row[18].nullable_to_f,
                       :quant_composite_behavioral => row[19].nullable_to_f,
                       :quant_fundamental_pe => row[20].nullable_to_f,
                       :quant_fundamental_pcf => row[21].nullable_to_f,
                       :quant_fundamental_pb => row[22].nullable_to_f,
                       :quant_fundamental_div => row[23].nullable_to_f,
                       :quant_composite_fundamental => row[24].nullable_to_f,
                       :quant_global_sector => row[25].nullable_to_f,
                       :quant_global_country => row[26].nullable_to_f,
                       :quant_composite_global => row[27].nullable_to_f,
                       :quant_quality_liquidity => row[28].nullable_to_f,
                       :quant_quality_diversification => row[29].nullable_to_f,
                       :quant_quality_firm => row[30].nullable_to_f,
                       :quant_composite_quality => row[31].nullable_to_f,
                       :quant_grade => row[32])
    if rec.valid?
      rec.save!
    else
      puts "#{fname}: line #{idx}\n#{row}\n#{rec.errors.full_messages.to_sentence}"
    end
    
    idx += 1
  end
end
  
if 0 == Action.count
  category = ActionCategory.create!(:name => 'API Access')

  category.actions.create!(:description => :read_industry)
  category.actions.create!(:description => :read_analytics)
  category.actions.create!(:description => :read_fund_flow)
  category.actions.create!(:description => :read_constituents)

  all_access = Action.all
  ['icefeed', 'etpdata', 'cloudquote', 'icedata', 'icesignal', 'icebedge', 'pdtpartners', 'steadfastcap', 'fintechstudio', 'istra', 'bwater', 
   'wellington', 'wquant', 'wallachbeth', 'creditsdone', 'bodhitree', 'dbetfsales'].each do |username|
     u = User.find_by_username(username)
     
     u.actions << all_access
   end
   
   constituents_only = Action.find_by_description(:read_constituents)
   ['htdonline', 'ensofinancial', 'quantopian'].each do |username|
     u = User.find_by_username(username)
     
     u.actions << constituents_only
   end
   
   u = User.find_by_username('lsi_user')
   u.actions << Action.find_by_description(:read_industry)
   
   u = User.find_by_username('etfg_direct')
   u.actions << Action.find_by_description(:read_industry)
   u.actions << Action.find_by_description(:read_constituents)

   u = User.find_by_username('fidopb')
   u.actions << Action.find_by_description(:read_industry)
   u.actions << Action.find_by_description(:read_fund_flow)
   u.actions << Action.find_by_description(:read_constituents)
   
   u = User.find_by_username('koyfin')
   u.actions << Action.find_by_description(:read_industry)
   u.actions << Action.find_by_description(:read_fund_flow)
   u.actions << Action.find_by_description(:read_constituents)
end
