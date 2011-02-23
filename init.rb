require 'rubygems'
require 'pivotal-tracker'

require 'main'

Dir['lib/*.rb'].each do |file|
  require file
end

YAML.load_file('pivotal_config.yml').each do |option, value|
  PivotalTracker::Client.send "#{option}=", value
end
