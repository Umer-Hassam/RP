class WorkDurationsController < ApplicationController
  before_action :set_work_duration, only: [:show, :edit, :update, :destroy]

  # GET /work_durations
  # GET /work_durations.json
  def index
    @work_durations = WorkDuration.all
  end

  # GET /work_durations/1
  # GET /work_durations/1.json
  def show
  end

  # GET /work_durations/new
  def new
    @work_duration = WorkDuration.new

    pid = params[:pid] == nil ? current_user.profile.id : params[:pid] 
    @employee = Profile.where(:id => pid).first.employee
  end

  # GET /work_durations/1/edit
  def edit

    eid = params[:eid] == nil ? current_user.id : params[:eid] 
    @employee = Profile.where(:id => pid).first

  end

  # POST /work_durations
  # POST /work_durations.json
  def create
    today = Date.today # Today's date %>
    days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map

    employee = Employee.where(:id => params["work_duration"]["eid"]).first

    # First iterate over all the vendors this employee has
    for vendor in employee.vendors
      # Project is the relationship between employee and vendor, also workDuration record is attached to this relationship so we need to fetch it first
      project = employee.projects.where(:vendor_id => vendor.id).first

      # Next iterate over all the hours each day has
      (today.at_beginning_of_week..today.at_end_of_week).map.each_with_index do |day, index|

        # extract the number of hours for each 
        hours_worked = params["work_duration"][["a","b","c","d","e","f","g"][index]+vendor.id.to_s]


        # Try to fetch the work duration object for the day that we are iterating over
        @work_duration = project.work_durations.where(work_day:day).first

        # if we did not find a pre existing work duration create new one else update oldone
        if @work_duration == nil
          @work_duration = project.work_durations.create(hours:hours_worked, work_day:day)
        else
          @work_duration.update_attributes(:hours => hours_worked)
        end
      end
    end
    #@work_duration = WorkDuration.new(work_duration_params)

    respond_to do |format|
      if @work_duration.save
        format.html { redirect_to employee, notice: 'Work duration was successfully created.' }
        format.json { render :show, status: :created, location: @work_duration }
      else
        format.html { render :new }
        format.json { render json: @work_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_durations/1
  # PATCH/PUT /work_durations/1.json
  def update
    respond_to do |format|
      if @work_duration.update(work_duration_params)
        format.html { redirect_to @work_duration.employee, notice: 'Work duration was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_duration }
      else
        format.html { render :edit }
        format.json { render json: @work_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_durations/1
  # DELETE /work_durations/1.json
  def destroy
    @work_duration.destroy
    respond_to do |format|
      format.html { redirect_to work_durations_url, notice: 'Work duration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_duration
      @work_duration = WorkDuration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_duration_params
      params.require(:work_duration).permit(:hours, :work_day, :employee_id, :a, :b, :c, :d, :e, :f, :g)
    end
end
