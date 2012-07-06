class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(leaves)
    # return manager path if role is admin
    if current_user.role == 'admin'
      user_management_user_path(current_user.id)
    elsif current_user.role == 'employee' or current_user.role == 'manager'
      # return leaves path
      leaves_path
    end
  end

end
