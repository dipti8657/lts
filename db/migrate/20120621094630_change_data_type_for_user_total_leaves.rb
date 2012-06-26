class ChangeDataTypeForUserTotalLeaves < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :total_leaves, :float
    end
  end

  def down
    change_table :users do |t|
      t.change :total_leaves, :integer
    end
  end
end
