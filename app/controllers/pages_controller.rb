class PagesController < ApplicationController
  def home
    @activities = Activity.all
    @dates_with_activities = @activities.distinct.pluck(:date).each
    @dates_with_mileage = []
    @dates_with_activities.each do |date|
      date = date
      mileage = get_mileage_in_date(date)
      date_info = {
        date: date,
        mileage: mileage
      }
      @dates_with_mileage.push(date_info)
    end
  end

  def activities_in_date
    @date = params[:date].to_s
    @activities = Activity.where("date = '#{@date}'")
    @total_mileage = get_mileage_in_date(@activities)
    puts @total_mileage
  end

  private
  def get_mileage_in_date(date)
    activities = Activity.where("date = '#{date}'")
    mileage = 0
    activities.each do |activity|
      mileage += activity[:warmup].to_f
      mileage += activity[:activity].to_f
      mileage += activity[:cooldown].to_f
    end
    mileage
  end
end