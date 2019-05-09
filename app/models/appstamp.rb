class Appstamp < ApplicationRecord
  def self.check_for_inactive_games
    last_check = Appstamp.first.last_activity_check
    if (Time.now - last_check) / 1.hour > 5
      #IF MORE THAN X HOURS HAVE PASSED, DO A INACTIVITY CHECK  
      #THEN RESTAMP THE CHECK COLUMN WITH CURRENT TIME
    else
      #IUNNO YOU'RE FINE LOL
    end
  end
end
