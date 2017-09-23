# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Time::DATE_FORMATS[:custom_datetime] = "%a %d %b %Y"
Time::DATE_FORMATS[:hour_datetime] = "%a %d %b %Y %H %M"
Mime::Type.register 'application/pdf', :pdf
