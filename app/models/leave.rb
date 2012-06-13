class Leave < ActiveRecord::Base
  belongs_to :user
  before_save :no_of_days_for_leave
  validate :startdate_cannot_be_greater_than_enddate, :on => :create
  validates :start_date, :date => { :after => Time.now }

  validates_presence_of :reason, :on => :create, :message => "must not be blank"

  def startdate_cannot_be_greater_than_enddate
    if (self.start_date > self.end_date)
      errors.add(:start_date, "must be earlier than end date")
    end
  end

  def no_of_days_for_leave
    @govt_holiday = Holiday.where(["date between ? and ? ", start_date, end_date]).count
   # logger.info "select uGetBussinessDays('#{start_date}','#{end_date}')"

    @try_holiday = Holiday.where(["date between ? and ? ", start_date, end_date])
  # @try_holiday1 = Holiday.find_by_sql ("select  dayname '#{try_holiday}'").first.date
    business_days = connection.select_all("select uGetBussinessDays('#{start_date}','#{end_date}') as bd").first
    flag = true
    @try_holiday.each do |holiday|
      storedate = holiday.date
      try_holiday2 = storedate.strftime("%A")
      debugger
      if ((try_holiday2 == 'Saturday' or try_holiday2 == 'Sunday') and flag == true)
        self.no_of_days = business_days['bd'].to_i
      else
        self.no_of_days = business_days['bd'].to_i - @govt_holiday
        flag = false
      end
    end
   #storedate = @try_holiday.first.date

    #@weekday = Holiday.select(uGetBussinessDays(start_date, end_date))
    #if @govt_holiday == 0 and @weekday == 0
      #self.no_of_days = (end_date.to_datetime - start_date.to_datetime) + 1
    #elsif @govt_holiday > 0 and @weekday == 0
      #@holiday1 = (end_date.to_datetime - start_date.to_datetime) + 1
      #self.no_of_days = @holiday1 - @govt_holiday
    #elsif @govt_holiday > 0 and @weekday > 0
      #@holiday2 = (end_date.to_datetime - start_date.to_datetime) + 1
      #@holiday3 = @holiday2 - @govt_holiday
      #self.no_of_days = @holiday3 - @weekday
    #elsif @weekday > 0 and @govt_holiday == 0
      #@holiday4 = (end_date.to_datetime - start_date.to_datetime) + 1
      #self.no_of_days = @holiday4 - @weekday
    #end
  end


#  if !self.no_of_days.blank?
#      n_digits = self.no_of_days.to_s.scan(/[0-9]/).size
#      if n_digits > 2
#        errors.add(" No of day's of leaves maximum two digit" )
#      end
#  end

#  if !self.no_of_days.blank?
#    if self.no_of_days.to_i < 1
#      errors.add(" Please Enter valid no of day's" )
#    end
#  end

  def validate_leave_details(year)
    self # leave

    @setup = Setup.where(['year = ?', Time.now.year]).first
    if @setup.total_leaves >= Leave.where(:current_status => "Approved").where(:user_id => self.user_id).sum(:no_of_days)
      true
    else
      false
    end
  end

end

