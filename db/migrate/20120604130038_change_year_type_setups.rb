class ChangeYearTypeSetups < ActiveRecord::Migration
  def change
    change_column :setups, :year, :integer
  end
end
