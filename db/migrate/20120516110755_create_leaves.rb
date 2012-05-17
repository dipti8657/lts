class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.references :User_id
      t.datetime :Applied_on
      t.datetime :Start_Date
      t.datetime :End_Date
      t.integer :No_of_Days
      t.string :Current_Status

      t.timestamps
    end
    add_index :leaves, :User_id_id
  end
end
