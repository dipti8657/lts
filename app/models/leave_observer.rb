class LeaveObserver < ActiveRecord::Observer
  def after_create(leave)
    after_create :send_email_to_manager, :if => :manager_wants_emails?
  end

end
