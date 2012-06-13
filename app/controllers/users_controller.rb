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
    @user = User.find(params[:id])
    if params[:commit] == "Change"
      @user.manager_id = params[:manager_id]
    end
    if params[:commit] == "Save"
      @user.manager_id = params[:manager_id]
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), notice: 'Manager has changed' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def user_management
    @users = User.all
    #@users = User.find(:all, :conditions => ['id = ?' , "#{current_user.manager_id}%"])
    respond_to do |format|
      format.html
    end
  end

end
