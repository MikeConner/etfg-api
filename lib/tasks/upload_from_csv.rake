require 'csv'

namespace :db do
  desc "Upload csv data"
  task :upload_data, [:table, :flush, :historical] => :environment do |t, args|
    flush(args[:table]) if 1 == args[:flush]
    
    errors = 0
    exceptions = 0
    file_exceptions = 0
    
    File.open("#{args[:table]}-log.txt", 'w') do |flog|
      data_files = 1 == args[:historical] ? Dir["/data/csv_output/arc_#{args[:table]}/*.csv"] : Dir["/data/csv_output/#{args[:table]}/*.csv"]
      num_files = data_files.count
      puts "Loading #{num_files} #{args[:table]} files"
      cnt = 1
      data_files.each do |fname|
        idx = 1
        pct = cnt.to_f / num_files.to_f * 100.0
        puts "File #{cnt} (#{pct.round(1)}%)"
        cnt += 1
        
        begin
          CSV.foreach(fname, :encoding => 'iso-8859-1:utf-8') do |row|
            rec = load_recs(args[:table], row)
            
            if rec.valid?
              begin
                rec.save!
              rescue Exception => ex
                flog.write("#{fname}: line #{idx}\n    #{row}\n    Exception: #{ex.message}\n")
                exceptions += 1
              end
            else
              flog.write("#{fname}: line #{idx}\n    #{row}\n    #{rec.errors.full_messages.to_sentence}\n")
              errors += 1
            end
          
            idx += 1
          end  
        rescue Exception => ex
          flog.write("#{fname}: line #{idx}\n    File exception on #{fname}: #{ex.message}\n")
          file_exceptions += 1
        end  
      end
      
      puts "#{errors} Errors; #{exceptions} Exceptions; #{file_exceptions} File Exceptions"
      num_recs = count_records(args[:table])
      if 0 == num_recs
        puts "Error rate: 100%"
      else
        pct = (errors + exceptions + file_exceptions).to_f / num_recs * 100.0
        puts "Error rate: #{pct.round(4)}% on #{num_recs} records"
      end
    end
  end  
  
  def flush(table)
    case table
    when 'industry'
      Industry.delete_all
    when 'fundflow'
      FundFlow.delete_all
    when 'analytics'
      Analytic.delete_all
    when 'constituents'
      Constituent.delete_all
    else
      raise 'Unknown table'
    end
  end
  
  def count_records(table)
    case table
    when 'industry'
      Industry.count.to_f
    when 'fundflow'
      FundFlow.count.to_f
    when 'analytics'
      Analytic.count.to_f
    when 'constituents'
      Constituent.count.to_f
    else
      raise 'Unknown table'
    end
  end

  def process_run_date(str)
    result = Date.parse(str) rescue nil
    if result.nil?
      result = Date.strptime(row[0], "%m/%d/%Y") rescue nil
    end
    
    result  
  end
  
  def load_recs(table, row)
    run_date = process_run_date(row[0])
    
    case table
    when 'industry'
      Industry.new(:run_date => run_date,
                   :composite_ticker => row[1],
                   :issuer => row[2].nullable,
                   :name => row[3].nullable,
                   :inception_date => (Date.parse(row[4]) rescue nil),
                   :related_index => row[5].nullable,
                   :tax_classification => row[6].nullable,
                   :is_etn => row[7].nullable_to_boolean,
                   :fund_aum => row[8].nullable_to_f,
                   :avg_volume => row[9].nullable,
                   :asset_class => row[10].nullable,
                   :category => row[11].nullable,
                   :focus => row[12].nullable,
                   :development_level => row[13].nullable,
                   :region => row[14].nullable,
                   :is_leveraged => row[15].nullable_to_boolean,
                   :leverage_factor => row[16].nullable,
                   :active => row[17].nullable_to_boolean,
                   :administrator => row[18].nullable,
                   :advisor => row[19].nullable,
                   :custodian => row[20].nullable,
                   :distributor => row[21].nullable,
                   :portfolio_manager => row[22].nullable,
                   :subadvisor => row[23].nullable,
                   :transfer_agent => row[24].nullable,
                   :trustee => row[25].nullable,
                   :futures_commission_merchant => row[26].nullable,
                   :fiscal_year_end => row[27].nullable,
                   :distribution_frequency => row[28].nullable,
                   :listing_exchange => row[29].nullable,
                   :creation_unit_size => row[30].nullable_to_f,
                   :creation_fee => row[31].nullable_to_f,
                   :geographic_exposure => row[32].nullable,
                   :currency_exposure => row[33].nullable,
                   :sector_exposure => row[34].nullable,
                   :industry_group_exposure => row[35].nullable,
                   :industry_exposure => row[36].nullable,
                   :subindustry_exposure => row[37].nullable,
                   :coupon_exposure => row[38].nullable,
                   :maturity_exposure => row[39].nullable,
                   :option_available => row[40].nullable_to_boolean,
                   :option_volume => row[41].nullable,
                   :short_interest => row[42].nullable_to_f,
                   :put_call_ratio => row[43].nullable,
                   :num_constituents => row[44].nullable_to_f,
                   :discount_premium => row[45].nullable_to_f,
                   :bid_ask_spread => row[46].nullable_to_f,
                   :put_vol => row[47].nullable,
                   :call_vol => row[48].nullable,
                   :management_fee => row[49].nullable_to_f,
                   :other_expenses => row[50].nullable_to_f,
                   :total_expenses => row[51].nullable_to_f,
                   :fee_waivers => row[52].nullable_to_f,
                   :net_expenses => row[53].nullable_to_f,
                   :lead_market_maker => row[54].nullable)
    when 'fundflow'
      FundFlow.new(:run_date => run_date,
                   :composite_ticker => row[1],
                   :shares => row[2].nullable_to_f,
                   :nav => row[3].nullable_to_f,
                   :value => row[4].nullable_to_f)
    when 'analytics'
      Analytic.new(:run_date => run_date,
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
                   :quant_grade => row[32].nullable)
    when 'constituents'
      Constituent.new(:run_date => run_date,
                      :composite_ticker => row[1],
                      :identifier => row[2].nullable,
                      :constituent_name => row[3].nullable,
                      :weight => row[4].nullable_to_f,
                      :market_value => row[5].nullable_to_f,
                      :cusip => row[6].nullable,
                      :isin => row[7].nullable,
                      :figi => row[8].nullable,
                      :sedol => row[9].nullable,
                      :country => row[10].nullable,
                      :exchange => row[11].nullable,
                      :total_shares_held => row[12].nullable_to_f,
                      :market_sector => row[13].nullable,
                      :security_type => row[14].nullable)
    else
      raise 'Unknown table'
    end    
  end  
end
