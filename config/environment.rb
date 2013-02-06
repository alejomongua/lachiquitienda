# Load the rails application
require File.expand_path('../application', __FILE__)
require "#{Rails.root}/app/overrides/date"

GMAIL_CONFIG = YAML.load_file("#{::Rails.root}/config/gmail.yml")[::Rails.env]
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]

# Initialize the rails application
Login::Application.initialize!