class AddReasonToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :Reason, :string
  end
end
