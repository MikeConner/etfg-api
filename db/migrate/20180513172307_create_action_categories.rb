class CreateActionCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :action_categories do |t|
      t.string :name, :null => false

      t.timestamps
    end
    
    add_index :action_categories, :name, :unique => true
  end
end
