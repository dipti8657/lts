class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.integer :total_leaves
      t.datetime :year

      t.timestamps
    end
  end
end
