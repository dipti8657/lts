class AddTotalLeavesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_leaves, :integer
  end
end
