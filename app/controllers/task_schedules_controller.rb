class TaskSchedulesController < ApplicationController
  before_action :set_task_schedule, only: [:show, :edit, :update, :destroy]

  # GET /task_schedules
  # GET /task_schedules.json
  def index
    @task_schedules = TaskSchedule.all
  end

  # GET /task_schedules/1
  # GET /task_schedules/1.json
  def show
  end

  # GET /task_schedules/new
  def new
    @task_schedule = TaskSchedule.new
  end

  # GET /task_schedules/1/edit
  def edit
  end

  # POST /task_schedules
  # POST /task_schedules.json
  def create
    @task_schedule = TaskSchedule.new(task_schedule_params)

    respond_to do |format|
      if @task_schedule.save
        format.html { redirect_to @task_schedule, notice: 'Task schedule was successfully created.' }
        format.json { render :show, status: :created, location: @task_schedule }
      else
        format.html { render :new }
        format.json { render json: @task_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_schedules/1
  # PATCH/PUT /task_schedules/1.json
  def update
    respond_to do |format|
      if @task_schedule.update(task_schedule_params)
        format.html { redirect_to @task_schedule, notice: 'Task schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_schedule }
      else
        format.html { render :edit }
        format.json { render json: @task_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_schedules/1
  # DELETE /task_schedules/1.json
  def destroy
    @task_schedule.destroy
    respond_to do |format|
      format.html { redirect_to task_schedules_url, notice: 'Task schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_schedule
      @task_schedule = TaskSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_schedule_params
      params.require(:task_schedule).permit(:name, :due_date, :user_id)
    end
end
