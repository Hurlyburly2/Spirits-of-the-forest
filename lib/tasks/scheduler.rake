desc "Checks for inactive users in matches, sends reminders, and "
task :check_inactivity => :environment do
  Appstamp.check_for_inactive_games
  
  user = User.first
  to = "dougdougmann@gmail.com"
  subject = "You have idle games ongoing in Spirits of the Forest!"
  from = "Spirits-of-the-Forest-Game@Spirits-of-the-Forest-game.com"
  content = "Hi #{user.username}!
  You have games in Spirits of the Forest you've been idle in for over 24 hours! If you don't take a move in another 24 hours, you will automatically concede :("
  data = {
    "personalizations"=> [
      {
        "to" => [
          {
            "email"=> to
            }
          ],
          "subject"=> subject
        }
      ],
      "from" => {
        "email"=> from
      },
      "content" => [
        {
          "type"=>"text/plain",
          "value"=> content
        }
      ]
  }
  
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._("send").post(request_body: data)
  puts response.status_code
  puts response.body
  puts response.headers
end
