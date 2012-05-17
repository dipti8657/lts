class LeavesController < ApplicationController
  def create
    @leave = Leave.new(params[:leave])
    respond_to do |format|
      if @leave.save
        format.html { redirect_to leafe_path(@leave), notice: 'Leave is Submitted' }
      else
        format.html { render action :"new" }
      end
    end
  end

  def apply
    @leave = Leave.new
    respond_to do |format|
      format.html
    end
  end

  def update

  end

  def index
    @leaves = Leave.all
  end

  def show
    @leave = Leave.find(params[:id])
    respond_to do |format|
      format.html
    end

  end

end
