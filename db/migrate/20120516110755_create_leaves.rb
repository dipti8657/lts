class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.references :user,  :null => false, :foreign_key => true
      t.datetime :applied_on
      t.datetime :start_date
      t.datetime :end_date
      t.integer :no_of_days
      t.string :current_status

      t.timestamps
    end
    add_index :leaves, :user_id
  end
end
