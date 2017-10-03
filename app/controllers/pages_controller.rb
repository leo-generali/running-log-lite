class PagesController < ApplicationController
  def home
    @activities = Activity.all
  end
end
