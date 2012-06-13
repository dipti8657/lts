class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.datetime :date
      t.string :event

      t.timestamps
    end
  end
end
