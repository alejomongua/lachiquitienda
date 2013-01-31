# Load the rails application
require File.expand_path('../application', __FILE__)
require "#{Rails.root}/app/overrides/date"

# Initialize the rails application
Login::Application.initialize!