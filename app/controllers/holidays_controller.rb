class HolidaysController < ApplicationController
  def index
    @holidays = Holiday.all
  end

  def create
   # @holiday = current_user.holidays.build(params[:holiday])
    @holiday = Holiday.new(params[:holiday])
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to holidays_index_path(@holiday), notice: 'Holiday is Submitted' }

      else
        format.html { render action: "new" }
      end
    end
  end

  def new
    @holiday = Holiday.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def show
    @holiday = Holiday.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

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

  def destroy
    @holiday = Holiday.find_by_id(params[:id])
    @holiday.destroy
    flash[:notice] = 'Holiday is successfully deleted.'
    redirect_to :action => 'index'
  end

end
