class AddDefaultValueToRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "employee"
  end
end
