require 'rails/generators/active_record/migration/migration_generator'

class ApiMigrationGenerator < ActiveRecord::Generators::MigrationGenerator
  source_root File.join(File.dirname(ActiveRecord::Generators::MigrationGenerator.instance_method(:create_migration_file).source_location.first), "templates")
 
  def create_migration_file
    set_local_assigns!
    validate_file_name!
    migration_template @migration_template, "db_v2/migrate/#{file_name}.rb"
    
    # Replace base class migration with Feed subclass
    # We don't know the time string it's going to prepend, so find it by "endsWith" the known part of the file_name
    full_path = Dir[Rails.root.join("db_v2/migrate") + "*#{file_name}.rb"][0]
    
    unless full_path.nil?
      text = File.read(full_path)
      # Rails 5 needs the version! Even on derived classes, so must preserve this
      if text =~ /ActiveRecord::Migration\[(.*?)\]/
        new_class = "Apiv2MigrationBase[#{$1}]"
      end
      new_contents = text.gsub(/ActiveRecord::Migration\[(.*?)\]/, new_class)
      
      File.open(full_path, "w") { |file| file.puts new_contents }
    end
  end  
end
