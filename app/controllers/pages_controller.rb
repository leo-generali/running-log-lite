class PagesController < ApplicationController
  def home
    @activities = Activity.all
  end

  def activities_in_date
    @date = params[:date].to_s
    @activities = Activity.where("date = '#{@date}'")
    puts @activities
  end

  private
  def get_activities_in_date
  end
end