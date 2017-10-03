class Activity < ApplicationRecord
  
  def total_mileage
    miles = 0
    unless self.warmup.nil?
      miles += self.warmup
    end
    unless self.activity.nil?
      miles += self.activity
    end
    unless self.cooldown.nil?
      miles += self.cooldown
    end
    miles
  end

end
