class UsersController < ApplicationController
  def index
    @users = User.all
      respond_to do |format|
      format.html
    end
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    @setup = Setup.find(:all, :conditions => ['year = ?', "#{Time.now.year}"])
    #Rails.logger.info(@user.errors.messages.inspect)
    @user = User.find(params[:id])
    if params[:commit] == "Change"
      @user.manager_id = params[:manager_id]
      @user.joining_date = params[:joining_date]
      @user.role = params[:role]
    end

    #respond_to do |format|
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => 'Employees info has changed'
    else
      Rails.logger.info(@user.errors.messages.inspect)
      render :edit
    end
    #end
    #@setup = Setup.find(:all, :conditions => ['year = ?', "#{Time.now.year}"])
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def user_management
    @users = User.non_admins
    #@users = User.find(:all, :conditions => ['id = ?' , "#{current_user.manager_id}%"])
    respond_to do |format|
      format.html
    end

  end

end
