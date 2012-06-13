class AddApprovedByToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :approved_by, :integer

  end
end
