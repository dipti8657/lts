class HolidaysController < ApplicationController

  # returns yearwise holiday list 
  def index
    @holidays_by_year = Holiday.find(:all, :conditions => ['year(date) = ?',  Time.now.year])
    if params[:commit] == "set"
      @holidays_by_year = Holiday.find(:all, :conditions => ['year(date) = ?', params[:date][:year]])
    end
  end

  # create new holiday entry and saves it in appropriate yearwise holiday list
  def create
    @holiday = Holiday.new(params[:holiday])

    respond_to do |format|
      if @holiday.save
        format.html { redirect_to holidays_index_path(@holiday), notice: 'Holiday is Submitted' }

      else
        format.html { render action: "new" }
      end
    end
  end

  # create new holiday entry
  def new
    @holiday = Holiday.new
    respond_to do |format|
      format.html
    end
  end

  # edit holiday date or holiday name
  def edit
    @holiday = Holiday.find(params[:id])
  end

  # show holiday
  def show
    @holiday = Holiday.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # updates holiday date or holiday name and saves updated holiday
  def update
    @holiday = Holiday.find(params[:id])

    respond_to do |format|
      if @holiday.update_attributes(params[:holiday])
        format.html { redirect_to holiday_path(@holiday), notice: 'Holiday is successfully updated' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # delete holiday entry(in case)
  def destroy
    @holiday = Holiday.find_by_id(params[:id])
    @holiday.destroy
    flash[:notice] = 'Holiday is successfully deleted.'
    redirect_to :action => 'index'
  end

end
