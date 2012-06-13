class Holiday < ActiveRecord::Base
before_save :day_from_date

 def self.day_from_date
    @holidays.each do |h|
      h.day = h.date.strftime("%A")
    end
 end

end
