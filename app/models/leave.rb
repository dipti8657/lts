class Leave < ActiveRecord::Base
  # Leave belongs to user and user has many leaves
  belongs_to :user
  # before save,no of days for leave calculated
  before_save :no_of_days_for_leave
  # while applying leave start date of leave must be less than end date of leave
  validate :startdate_cannot_be_greater_than_enddate, :on => :create
  # user must have give reason for taking leave 
  validates_presence_of :reason, :on => :create, :message => "must not be blank"
  
  # end date of leave must be greater than start date of leave
  def startdate_cannot_be_greater_than_enddate
    if (self.start_date > self.end_date)
      errors.add(:start_date, "must be earlier than end date")
    end
  end

  # no of days for leave automatically calculated, excluding weekends and holidays
  def no_of_days_for_leave
    @govt_holiday = Holiday.where(["date between ? and ? ", start_date, end_date]).count

    business_days = connection.select_all("select uGetBussinessDays('#{start_date}','#{end_date}') as bd").first

    self.no_of_days = business_days['bd'].to_i - @govt_holiday

  end


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

