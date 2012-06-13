class ChangeDataTypeOfHolidayDate < ActiveRecord::Migration
  def up
     change_table :holidays do |t|
      t.change :date, :date
     end
  end

  def down
  end
end
