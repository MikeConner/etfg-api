namespace :db do
  desc "Upload the FundFlow data"
  task :upload_fundflow => :environment do
    File.open('fundflow-log.txt', 'w') do |flog|
      flow_files = Dir['/data/csv_output/fundflow/*.csv']
      num_files = flow_files.count
      puts "Loading #{num_files} FundFlow files"
      cnt = 1.0
      flow_files.each do |fname|
        idx = 1
        pct = cnt / num_files.to_f * 100.0
        puts "#{pct.round}%"
        cnt += 1.0
        
        CSV.foreach(fname) do |row|
          rec = FundFlow.new(:run_date => (Date.parse(row[0]) rescue nil),
                             :composite_ticker => row[1],
                             :shares => row[2].nullable_to_f,
                             :nav => row[3].nullable_to_f,
                             :value => row[4].nullable_to_f)
          if rec.valid?
            rec.save!
          else
            flog.write("#{fname}: line #{idx}\n    #{row}\n    #{rec.errors.full_messages.to_sentence}\n")
          end
        
          idx += 1
        end    
      end
    end
  end
end
