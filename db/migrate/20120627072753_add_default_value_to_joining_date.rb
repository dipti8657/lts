class AddDefaultValueToJoiningDate < ActiveRecord::Migration
  def change
    change_column :users, :joining_date, :date, :default => "2012-01-01"
  end
end
