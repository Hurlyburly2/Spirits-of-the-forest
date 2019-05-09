class Appstamp < ApplicationRecord
  def self.check_for_inactive_games
    last_check = Appstamp.first.last_activity_check
    if (Time.now - last_check) / 1.hour > 5
      binding.pry
    else
      binding.pry
    end
  end
end
