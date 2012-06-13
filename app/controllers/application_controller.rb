class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(leaves)
    if current_user.role == 'Admin'
      user_management_user_path(current_user.id)
    elsif current_user.role == 'Employee' or current_user.role == 'Manager'
      leaves_path
    end
  end

end
