require 'rails/generators/active_record/model/model_generator'

class FeedModelGenerator < ActiveRecord::Generators::ModelGenerator
  source_root File.join(File.dirname(ActiveRecord::Generators::ModelGenerator.instance_method(:create_migration_file).source_location.first), "templates")

  def create_migration_file
    return unless options[:migration] && options[:parent].nil?

    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    migration_template "../../migration/templates/create_table_migration.rb", File.join("db_v2/migrate", "create_#{table_name}.rb")
    
    # Replace base class migration with Api subclass
    # We don't know the time string it's going to prepend, so find it by "endsWith" the known part of the file_name
    migrate_full_path = Dir[Rails.root.join("db_v2/migrate") + "*create_#{table_name}.rb"][0]
    
    unless migrate_full_path.nil?
      text = File.read(migrate_full_path)
      # Rails 5 needs the version! Even on derived classes, so must preserve this
      if text =~ /ActiveRecord::Migration\[(.*?)\]/
        new_class = "Apiv2MigrationBase[#{$1}]"
      end
      new_contents = text.gsub(/ActiveRecord::Migration\[(.*?)\]/, new_class)
      
      File.open(migrate_full_path, "w") { |file| file.puts new_contents }
    end 
    
    model_full_path = Rails.root.join("models").to_s + "/#{table_name.singularize}.rb"
    
    unless model_full_path.nil? or not File.exists?(model_full_path)
      text = File.read(model_full_path)
      new_contents = text.gsub(/ApplicationRecord/, "EtfgDbV2Base")
      File.open(model_full_path, "w") { |file| file.puts new_contents }    
    end 
  end
end
