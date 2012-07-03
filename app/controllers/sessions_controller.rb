class SessionsController < Devise::SessionsController
  def create
    session[:current_year] = Time.now.year.to_s
    super
  end
end
