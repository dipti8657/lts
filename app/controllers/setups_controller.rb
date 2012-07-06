class SetupsController < ApplicationController
  # returns setup of leaves for all year
  def index
    @setups = Setup.all
  end

  # displays setup
  def show
    @setup = Setups.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # create new setup
  def new
    @setup = Setup.new
    respond_to do |format|
      format.html
    end
  end

  # edit existing setup
  def edit
    @setup = Setup.find(params[:id])
  end

  # update setup details and saves updated details
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

  # creates new setup entry and if it valids saves it.
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

  # delete existing setup
  def destroy
    @setup = Setup.find_by_id(params[:id])
    @setup.destroy
    flash[:notice] = 'Setup is successfully deleted.'
    redirect_to :action => 'index'
  end

end


