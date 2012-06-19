class SetupsController < ApplicationController

  def index
    if current_user.role == 'admin' or current_user.role == 'manager'
      @setups = Setup.all
    else
      @setups = Setup.find(:all, :conditions =>['user_id =?', current_user.id])
    end
    #@remain_leaves = setups.get_remaining_leave
  end

  def show
    @setup = Setups.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @setup = Setup.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @setup = Setup.find(params[:id])
  end

  def update
    @setup = Setup.find(params[:id])
    respond_to do |format|
      if @setup.update_attributes(params[:setup])
        format.html { redirect_to setups_path, notice: 'Setup details successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    @setup = Setup.new(params[:setup])

    respond_to do |format|
      if @setup.save
        format.html { redirect_to setups_path, notice: 'Setup details Submitted' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @setup = Setup.find_by_id(params[:id])
    @setup.destroy
    flash[:notice] = 'Setup is successfully deleted.'
    redirect_to :action => 'index'
  end

end


