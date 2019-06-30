desc "Checks for inactive users in matches, sends reminders, and "
task :check_inactivity => :environment do
  Appstamp.check_for_inactive_games
end
