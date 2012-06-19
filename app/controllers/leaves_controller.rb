class LeavesController < ApplicationController
  def create
    @leave = current_user.leaves.build(params[:leave])
    @leave.current_status = "Pending"

    respond_to do |format|
      if @leave.save
       # LeaveMailer.leave_email(@leave).deliver
        format.html { redirect_to leave_path(@leave), notice: 'Leave is Submitted' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def new
    @leave = Leave.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @leave = Leave.find(params[:id])
  end

  def update
    @leave = Leave.find( params[:id])

    if params[:commit] == "Approve"
        @leave.current_status = "Approved"
        @leave.approved_by = current_user.id
        @leave.approved_on = Time.now
    end

    if params[:commit] == "Reject"
      @leave.current_status = "Rejected"
      @leave.approved_by = current_user.id
      @leave.rejection_reason = params[:rejection_reason]
    end

    respond_to do |format|
      if @leave.update_attributes(params[:leave])
        format.html { redirect_to leave_path(@leave), notice: 'Leave is successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def validate_leave_details
    @setup = Setup.where(['year = ?', Time.now.year]).first
    debugger
    @setup.each do |setup|
      if setup.total_leaves >= Leave.where(:current_status => "Approved").where(:user_id => "#{@leave.user_id}%").sum(:no_of_days)
        debugger
        flash[:notice] = "Hello world!"
      else
        return false
      end
    end
  end

  def destroy
    @leave = Leave.find_by_id(params[:id])
    @leave.destroy
    flash[:notice] = 'Leave is successfully deleted.'
    redirect_to :action => 'index', :id=>session[:user_id]
  end

  def index
    if current_user.role == 'admin' or current_user.role == 'manager'
      @leaves = Leave.find(:all)
    else
      @leaves = Leave.find(:all, :conditions =>['user_id =?', current_user.id])
    end
    @leaves_taken = Leave.where(:current_status => "Approved").where(:user_id => "#{current_user.id}%").sum(:no_of_days)
    @setups = Setup.find(:all, :conditions => ['year = ?', "#{Time.now.year}%"])
    #@setups = Setup.select("total_leaves").where(:year => "#{Time.now.year}%")
    @users = User.find(:all, :conditions => ['id = ?' , "#{current_user.manager_id}%"])
  end

  def show
    @leave = Leave.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def approve_reject
    @leaves = Leave.find(:all, :conditions =>['user_id = ? and current_status = ?', params[:user_id].to_i, 'Approved'])
    @leave = Leave.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
