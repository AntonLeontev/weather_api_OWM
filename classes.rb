require "net/http"
require "uri"
require "json"

class Weather
  def initialize(lat, lon)
    data = get_data(lat, lon)
    sorted_data = sort_data(data)

  end

  def get_data(lat, lon)
    uri = URI.parse("https://api.openweathermap.org/data/2.5/onecall" + 
      "?lat=#{lat}&lon=#{lon}&units=metric&exclude=hourly,daily" + 
      "&appid=1c501cf2fe713fa399e0cd06c5258e4d")
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def sort_data(data)
    @date        = /(\"dt\":)(\d+)/.match(data)[2]
    @sunrise     = /(\"sunrise\":)(\d+)/.match(data)[2]
    @sunset      = /(\"sunset\":)(\d+)/.match(data)[2]
    @temp        = /(\"temp\":)(\d+\.?\d*)/.match(data)[2]
    @feels_like  = /(\"feels_like\":)(\d+\.?\d*)/.match(data)[2]
    @humidity    = /(\"humidity\":)(\d+)/.match(data)[2]
    @wind_speed  = /(\"wind_speed\":)(\d+)/.match(data)[2]
    @wind_deg    = /(\"wind_deg\":)(\d+)/.match(data)[2]
    @main        = /(\"main\":)\"(\w+)\"/.match(data)[2]
    @description = /(\"description\":)\"([\w\s]+)\"/.match(data)[2]
  end
end
