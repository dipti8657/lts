class Holiday < ActiveRecord::Base
  
  validate :holiday_cannot_be_on_weekends
  
  def holiday_cannot_be_on_weekends
    if (self.date.strftime("%u") == "6" or self.date.strftime("%u") == "7")
      errors.add(:date, "Holiday should not be on weekends")
    end
  end

end
