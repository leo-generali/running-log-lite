class PagesController < ApplicationController
  def home
    @activities = Activity.order('date DESC')
    dates_by_week = @activities.group_by(&:week)
    weeks = dates_by_week.keys


    @weeks_with_activities = []
    weeks.each do |week|
      arr = []
      unique_dates_in_week = []
      dates_by_week[week].uniq{|x| x.date}.each do |activity|
        unique_dates_in_week.push(activity[:date])
      end

      unique_dates_in_week.each do |date|
        date = date
        mileage = get_mileage_in_date(date)
        date_info = {
          date: date,
          mileage: mileage
        }
        arr.push(date_info)
      end
      
      @weeks_with_activities.push(create_blank_date(arr))
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

  def create_blank_date(arr)
    arr_spot = arr.length - 1
    returnArr = []
    full_week = (arr[0][:date].beginning_of_week..arr[0][:date].end_of_week)
    full_week.each do |day|
      unless arr.any?{|i| i[:date] == day}
        returnArr.push({
          date: day,
          mileage: 0
          })
      else
        returnArr.push(arr[arr_spot])
        arr_spot -= 1
      end
    end
    returnArr
  end
end