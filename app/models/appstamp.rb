require 'sendgrid-ruby'
include SendGrid

class Appstamp < ApplicationRecord
  def self.check_for_inactive_games
    last_check = Appstamp.first.last_activity_check
    check_for_idle_duration = 6
    if (Time.now - last_check) / 1.hours > check_for_idle_duration
      game_idle_duration = 24
      games_to_check = Game.all
      idle_games = []
      concede_games = []
      
      games_to_check.each do |game|
        user = User.find(game.whose_turn_id)
        current_match = game.matches.where(user: user)[0]
        if user.reminders == true
          if (Time.now - game.updated_at) / 1.hour > game_idle_duration && current_match.reminded == false
            idle_games << game
            current_match.reminded = true
            current_match.save
            #REMINDER
          elsif (Time.now - game.updated_at) / 1.hour > game_idle_duration && current_match.reminded == true
            Game.concede_game_timeout(game)
            #CONCEDE GAME IN HERE
          end
        else
          if (Time.now - game.updated_at) / 1.hour > game_idle_duration && current_match.reminded == false
            current_match.reminded = true
            current_match.save
            #NO REMINDER, BUT ONE STEP CLOSER TO CONCESSION
          elsif (Time.now - game.updated_at) / 1.hour > game_idle_duration && current_match.reminded == true
            Game.concede_game_timeout(game)
            #CONCEDE GAME IN HERE
          end
        end
      end
      
      users_to_email = idle_games.map do |game|
        User.find(game.whose_turn_id)
      end
      users_to_email = users_to_email.uniq
      
      users_to_email.each do |user|
        Appstamp.sendReminder(user)
      end

      #IF MORE THAN X HOURS HAVE PASSED, DO A INACTIVITY CHECK  
      #THEN RESTAMP THE CHECK COLUMN WITH CURRENT TIME
      idle_timestamp = Appstamp.first
      idle_timestamp.last_activity_check = Time.now
      idle_timestamp.save
    else
      #NO CHECK FOR UPDATE
    end
  end
  
  def self.sendReminder(user)
    
    message = "Hi #{user.username}!
    You have games in Spirits of the Forest you've been idle in for over 24 hours! If you don't take a move in another 24 hours, you will automatically concede :("
    
    from = Email.new(email: 'Spirits-of-the-Forest-Game@Spirits-of-the-Forest-game.com')
    to = Email.new(email: user.email)
    subject = 'You have idle games ongoing in Spirits of the Forest!'
    content = Content.new(type: 'text/plain', value: message)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
