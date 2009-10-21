# /config/initializers/mailer.rb
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'phosney.com',
  :authentication => :plain,
  :user_name => 'support@example.com',
  :password => ''
}