class AddJoiningDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :joining_date, :date
  end
end
