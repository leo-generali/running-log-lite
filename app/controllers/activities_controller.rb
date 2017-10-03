class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.create(task_params)
    redirect_to root_path
  end

  def show
    @activity = Activity.find(params[:id])
  end

  private
  def activity_params
    params.require(:activity).permit(:title, :desc, :time, :date, :warmup, :activity, :cooldown, :race, :workout)
  end
end
