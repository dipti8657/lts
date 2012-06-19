class RemoveAppliedOnFromLeaves < ActiveRecord::Migration
  def up
    remove_column :leaves, :applied_on
  end

  def down
    add_column :leaves, :applied_on, :datetime
  end
end
