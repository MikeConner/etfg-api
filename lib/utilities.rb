require 'csv'

module Utilities  
  TESTED_DATA_BOUNDARY = Date.parse("2017-01-01")
  
  def self.csv_emitter(data)
   csv_string = CSV.generate do |csv|
      csv << data[0].keys
      
      data.each do |row|
        csv << row.values
      end
    end 
    
    csv_string   
  end
  
  def self.earliest_date(params, table)
    if params.has_key?(:date)
      # The date could be coming from the REST API or the legacy API
      # In the legacy case, it will be in the form "start:end". So if there is a colon, it's legacy and we need to split
      #   it into start and end.
      
      dates = params[:date].split(/:/)
      raise 'Invalid date range' if dates.count > 2
      
      resolve_date(dates[0], table)
    else
      resolve_date(params[:start_date], table)
    end     
  end
  
  # Parse dates and date ranges out of parameters (common to all functions)
  def self.date_clause(params, table)
    if params.has_key?(:date)
      # The date could be coming from the REST API or the legacy API
      # In the legacy case, it will be in the form "start:end". So if there is a colon, it's legacy and we need to split
      #   it into start and end.
      
      dates = params[:date].split(/:/)
      raise 'Invalid date range' if dates.count > 2
      
      1 == dates.count ? "run_date = '#{resolve_date(dates[0], table)}'" : 
                         "run_date >= '#{resolve_date(dates[0], table)}' AND run_date <= '#{resolve_date(dates[1], table)}'"
    else
      "run_date >= '#{resolve_date(params[:start_date], table)}' AND run_date <= '#{resolve_date(params[:end_date], table)}'"
    end
  end
  
  def self.resolve_date(date_param, table)
    if "current" == date_param.downcase
      case table
      when 'analytics'
        Analytic.maximum(:run_date)
      when 'fundflows'
        FundFlow.maximum(:run_date)
      when 'industries'
        Industry.maximum(:run_date)
      when 'constituents'
        Constituent.maximum(:run_date)
      else
        raise 'Invalid table'
      end
    else
      Date.parse(date_param)
    end
  end  
end