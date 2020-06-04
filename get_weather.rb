require "net/http"
require "uri"
require "rexml/document"
require "json"

require_relative 'classes.rb'

Weather.new(55.82, 37.656946)



# path = File.dirname(__FILE__) + "/weather_db.json"
# File.write(path, "#{response.body.to_json}\n")
