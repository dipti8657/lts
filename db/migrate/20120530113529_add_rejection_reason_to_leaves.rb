class AddRejectionReasonToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :rejection_reason, :string
  end
end
