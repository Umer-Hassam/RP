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
  end

  # GET /work_durations/1/edit
  def edit
  end

  # POST /work_durations
  # POST /work_durations.json
  def create
    @work_duration = WorkDuration.new(work_duration_params)

    respond_to do |format|
      if @work_duration.save
        format.html { redirect_to @work_duration.employee, notice: 'Work duration was successfully created.' }
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
      params.require(:work_duration).permit(:hours, :work_day, :employee_id)
    end
end
