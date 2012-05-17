class Leave < ActiveRecord::Base
  belongs_to :user
  #validates :Applied_On, :presence => true
  #validates :Start_Date, :presence => true
  #validates :End_Date, :presence => true
  #validates :No_of_Days, :presence => true
  #validates :Current_Status, :presence => true
  #validates :Reason, :presence => true
   def validate
    if self.Start_Date > self.End_Date
      errors.add(:start_date, 'must be earlier than end date')
    end
  end
end
