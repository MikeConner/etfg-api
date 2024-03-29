require 'csv'

module Utilities  
  TESTED_DATA_BOUNDARY = Date.parse("2017-05-01")
  
  def self.csv_emitter(data)
   csv_string = CSV.generate do |csv|
      csv << data[0].keys
      
      data.each do |row|
        csv << row.values
      end
    end 
    
    csv_string   
  end
  
  def self.earliest_date(params, table, version = 2)
    if params.has_key?(:date)
      # The date could be coming from the REST API or the legacy API
      # In the legacy case, it will be in the form "start:end". So if there is a colon, it's legacy and we need to split
      #   it into start and end.
      
      dates = params[:date].split(/:/)
      raise 'Invalid date range' if dates.count > 2
      
      resolve_date(dates[0], table, version)
    else
      resolve_date(params[:start_date], table, version)
    end     
  end
  
  # Parse dates and date ranges out of parameters (common to all functions)
  def self.date_clause(params, table, version = 2, date_field = 'run_date')
    if params.has_key?(:date)
      # The date could be coming from the REST API or the legacy API
      # In the legacy case, it will be in the form "start:end". So if there is a colon, it's legacy and we need to split
      #   it into start and end.
      
      dates = params[:date].split(/:/)
      raise 'Invalid date range' if dates.count > 2
      
      1 == dates.count ? "#{date_field} = '#{resolve_date(dates[0], table, version)}'" : 
                         "#{date_field} >= '#{resolve_date(dates[0], table, version)}' AND #{date_field} <= '#{resolve_date(dates[1], table, version)}'"
    else
      "#{date_field} >= '#{resolve_date(params[:start_date], table, version)}' AND #{date_field} <= '#{resolve_date(params[:end_date], table, version)}'"
    end
  end

  # Return an array of first/last dates (or just a 1-element array if there's one)
  def self.date_range(params, table, version = 2, date_field = 'run_date')
    if params.has_key?(:date)
      # The date could be coming from the REST API or the legacy API
      # In the legacy case, it will be in the form "start:end". So if there is a colon, it's legacy and we need to split
      #   it into start and end.
      
      dates = params[:date].split(/:/)
      raise 'Invalid date range' if dates.count > 2
      
      first_date = resolve_date(dates[0], table, version)
      1 == dates.count ? first_date..first_date : 
                         first_date..resolve_date(dates[1], table, version)
    else
      resolve_date(params[:start_date], table, version)..resolve_date(params[:end_date], table, version)
    end
  end
  
  def self.resolve_date(date_param, table, version)
    if "current" == date_param.downcase
      case table
      when 'analytics'
        1 == version ? Analytic.maximum(:run_date) : AnalyticV2.maximum(:run_date)
      when 'fundflows'
        1 == version ? FundFlow.maximum(:run_date) : FundFlowV2.maximum(:run_date)
      when 'industries'
        1 == version ? Industry.maximum(:run_date) : IndustryV2.maximum(:run_date)
      when 'constituents'
        1 == version ? Constituent.maximum(:run_date) : ConstituentV2.maximum(:run_date)
      when 'baskets'
        Basket.maximum(:run_date)
      when 'esg_cores'
        EsgCore.maximum(:etfg_date)
      when 'esg_ratings'
        EsgRating.maximum(:etfg_date)
      else
        raise 'Invalid table'
      end
    else
      Date.parse(date_param)
    end
  end  
end
