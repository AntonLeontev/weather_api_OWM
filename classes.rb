require "net/http"
require "uri"
require "json"

class Weather

  attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :humidity, 
  :wind_speed, :wind_deg, :main, :description

  def initialize(lat, lon)
    data = get_data(lat, lon)
    sort_data(data)
    process_data
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
    @temp        = /(\"temp\":)(-?\d+\.?\d*)/.match(data)[2]
    @feels_like  = /(\"feels_like\":)(-?\d+\.?\d*)/.match(data)[2]
    @humidity    = /(\"humidity\":)(\d+)/.match(data)[2]
    @wind_speed  = /(\"wind_speed\":)(\d+)/.match(data)[2]
    @wind_deg    = /(\"wind_deg\":)(\d+)/.match(data)[2]
    @main        = /(\"main\":)\"(\w+)\"/.match(data)[2]
    @description = /(\"description\":)\"([\w\s]+)\"/.match(data)[2]
  end

  def process_data
    @date        = Time.at(@date.to_i).strftime('%-d.%m %R')
    @sunrise     = Time.at(@sunrise.to_i).strftime('%H:%M')
    @sunset      = Time.at(@sunset.to_i).strftime('%H:%M')
    @temp        = @temp.to_f.round.to_s + "\u00B0" + 'C'
    @feels_like  = @feels_like.to_f.round.to_s + "\u00B0" + 'C'
    @humidity    = @humidity + '%'
    @wind_speed  = @wind_speed + ' м/с'
    @wind_deg    = case @wind_deg.to_i
                   when (0..23) || (338..360)
                      'северный'
                   when (24..68)
                      'северо-восточный'
                   when (69..113)
                      'восточный'
                   when (114..157)
                      'юго-восточный'
                   when (158..202)
                      'южный'
                   when (203..247)
                      'юго-западный'
                   when (248..292)
                      'западный'
                   when (293..337)
                      'северо-западный'
                   end
  end
end
