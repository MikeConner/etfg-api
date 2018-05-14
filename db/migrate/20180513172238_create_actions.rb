class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.references :action_category
      t.integer :description, :null => false

      t.timestamps
    end

    create_table :actions_users, :id => false do |t|
      t.references :action
      t.references :user
    end
    
    add_index :actions, :description, :unique => true
    add_index :actions_users, [:action_id, :user_id], :unique => true
  end
end
