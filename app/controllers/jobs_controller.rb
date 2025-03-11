class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: %i[show edit update destroy]

  def index
    @jobs = Job.all
    if params[:search].present?
      @jobs = @jobs.where("title ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    if params[:job_type].present?
      @jobs = @jobs.where(job_type: params[:job_type])
    end
    @jobs = @jobs.by_nearest_application_deadline
  end
   

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job, notice: 'Job successfully created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: 'Job deleted successfully!'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :job_type, :description, :application_deadline, :circular)
  end
end
