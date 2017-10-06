class PagesController < ApplicationController
  helper_method :check_date, :create_week_string, :create_race_activity_class

  def home
    @activities = Activity.order('date DESC').where("date < '#{DateTime.now}'")
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

  def races
    @activities = Activity.where(race: true).where("date < '#{DateTime.now}'")
  end

  def workouts
    @activities = Activity.where(workout: true).where("date < '#{DateTime.now}'")
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
    end
    boolean
  end

  def create_week_string(week)
    week[0][:date].strftime("%B %-d") + " - " + week[6][:date].strftime("%B %-d")
  end

  def check_if_race(activities)
    races = activities.where(race: true)
    "activity"
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

  def create_race_activity_class(date)
    classes = {
      title: "activity__title",
      miles: "activity__miles"
    }
    activities = Activity.where(race: true).where("date = '#{date}'")
    if activities.length >= 1
      classes[:title] += " activity__title--race"
      classes[:miles] += " activity__miles--race"
    end
    classes 
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
