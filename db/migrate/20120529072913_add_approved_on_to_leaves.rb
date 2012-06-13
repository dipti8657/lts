class AddApprovedOnToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :approved_on, :datetime
  end
end
