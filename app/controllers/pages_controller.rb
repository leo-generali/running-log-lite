class PagesController < ApplicationController
  helper_method :check_date, :create_week_string

  def home
    @activities = Activity.order('date DESC')
    dates_by_week = @activities.group_by(&:week)
    weeks = dates_by_week.keys

    @weeks_with_activities = []
    @weekly_mileages = []

    weeks.each do |week|

      arr = []
      weekly_mileage = 0

      unique_dates_in_week = []
      dates_by_week[week].uniq { | x | x.date }.each do |activity|
        unique_dates_in_week.push(activity[:date])
      end

      unique_dates_in_week.each do |date|
        date = date
        mileage = get_mileage_in_date(date)
        weekly_mileage += mileage

        date_info = {
          date: date,
          mileage: mileage
        }
        arr.push(date_info)
      end

      @weekly_mileages.push(weekly_mileage)
      @weeks_with_activities.push(create_blank_date(arr))
    end
  end

  def activities_in_date
    @date_str = params[:date].to_s
    @date = params[:date]
    @activities = Activity.where("date = '#{@date}'")
    @total_mileage = get_mileage_in_date(@activities)
  end

  def check_date(date)
    boolean = false
    if date > Date.today
      boolean = true
      puts "#{date} is after #{Date.today}"
    end
    boolean
  end

  def create_week_string(week)
    week[0][:date].strftime("%B %-d") + " - " + week[6][:date].strftime("%B %-d")
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
