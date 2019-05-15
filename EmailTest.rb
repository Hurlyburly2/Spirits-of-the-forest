# MEDIA QUERY SIZES

# @media (min-width:320px)  { /* smartphones, portrait iPhone, portrait 480x320 phones (Android) */ }
# @media (min-width:480px)  { /* smartphones, Android phones, landscape iPhone */ }
# @media (min-width:600px)  { /* portrait tablets, portrait iPad, e-readers (Nook/Kindle), landscape 800x480 phones (Android) */ }
# @media (min-width:801px)  { /* tablet, landscape iPad, lo-res laptops ands desktops */ }
# @media (min-width:1025px) { /* big landscape tablets, laptops, and desktops */ }
# @media (min-width:1281px)
# 
# # # using SendGrid's Ruby Library
# # # https://github.com/sendgrid/sendgrid-ruby


# require 'sendgrid-ruby'
# include SendGrid
# 
# from = Email.new(email: 'test@example.com')
# to = Email.new(email: 'dougdougmann@gmail.com')
# subject = 'Sending with SendGrid is Fun'
# content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
# mail = Mail.new(from, subject, to, content)
# 
# sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
# response = sg.client.mail._('send').post(request_body: mail.to_json)
# puts response.status_code
# puts response.body
# puts response.headers
