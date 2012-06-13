class LeaveObserver < ActiveRecord::Observer
  def after_save(leave)
  #   Notification.leave("dipti9979@gmail.com", "New leave was applied", leave).deliver
  end

end
