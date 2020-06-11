require "net/http"
require "uri"
require "json"

class WeatherForecast

  attr_reader :current, :hour_1, :hour_2, :hour_3, :hour_4, :hour_5, :hour_6, 
  :hour_7, :hour_8, :hour_9, :hour_10, :hour_11, :hour_12, :hour_13, :hour_14, 
  :hour_15, :hour_16, :hour_17, :hour_18, :hour_19, :hour_20, :hour_21, 
  :hour_22, :hour_23, :hour_24, :hour_25, :hour_26, :hour_27, :hour_28, 
  :hour_29, :hour_30, :hour_31, :hour_32, :hour_33, :hour_34, :hour_35, 
  :hour_36, :hour_37, :hour_38, :hour_39, :hour_40, :hour_41, :hour_42, 
  :hour_43, :hour_44, :hour_45, :hour_46, :hour_47, :hour_48, :day_1, :day_2,
  :day_3, :day_4, :day_5, :day_6, :day_7

  def initialize(lat, lon, appid)
    data = take_data(lat, lon, appid)
    split_data(data)
  end

  def take_data(lat, lon, appid)
    uri = URI.parse("https://api.openweathermap.org/data/2.5/onecall?lat=" +
      "#{lat}&lon=#{lon}&lang=ru&units=metric&exclude=minutely&appid=#{appid}")
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def split_data(data)
    doc    = JSON.parse(data)
    hourly = doc['hourly']
    daily  = doc['daily']

    @current = CurrentWeather.new(doc['current'])
    @day_1   = DailyWeather.new(daily[0])
    @day_2   = DailyWeather.new(daily[1])
    @day_3   = DailyWeather.new(daily[2])
    @day_4   = DailyWeather.new(daily[3])
    @day_5   = DailyWeather.new(daily[4])
    @day_6   = DailyWeather.new(daily[5])
    @day_7   = DailyWeather.new(daily[6])
    @hour_1  = HourWeather.new(hourly[0])
    @hour_2  = HourWeather.new(hourly[1])
    @hour_3  = HourWeather.new(hourly[2])
    @hour_4  = HourWeather.new(hourly[3])
    @hour_5  = HourWeather.new(hourly[4])
    @hour_6  = HourWeather.new(hourly[5])
    @hour_7  = HourWeather.new(hourly[6])
    @hour_8  = HourWeather.new(hourly[7])
    @hour_9  = HourWeather.new(hourly[8])
    @hour_10 = HourWeather.new(hourly[9])
    @hour_11 = HourWeather.new(hourly[10])
    @hour_12 = HourWeather.new(hourly[11])
    @hour_13 = HourWeather.new(hourly[12])
    @hour_14 = HourWeather.new(hourly[13])
    @hour_15 = HourWeather.new(hourly[14])
    @hour_16 = HourWeather.new(hourly[15])
    @hour_17 = HourWeather.new(hourly[16])
    @hour_18 = HourWeather.new(hourly[17])
    @hour_19 = HourWeather.new(hourly[18])
    @hour_20 = HourWeather.new(hourly[19])
    @hour_21 = HourWeather.new(hourly[20])
    @hour_22 = HourWeather.new(hourly[21])
    @hour_23 = HourWeather.new(hourly[22])
    @hour_24 = HourWeather.new(hourly[23])
    @hour_25 = HourWeather.new(hourly[24])
    @hour_26 = HourWeather.new(hourly[25])
    @hour_27 = HourWeather.new(hourly[26])
    @hour_28 = HourWeather.new(hourly[27])
    @hour_29 = HourWeather.new(hourly[28])
    @hour_30 = HourWeather.new(hourly[29])
    @hour_31 = HourWeather.new(hourly[30])
    @hour_32 = HourWeather.new(hourly[31])
    @hour_33 = HourWeather.new(hourly[32])
    @hour_34 = HourWeather.new(hourly[33])
    @hour_35 = HourWeather.new(hourly[34])
    @hour_36 = HourWeather.new(hourly[35])
    @hour_37 = HourWeather.new(hourly[36])
    @hour_38 = HourWeather.new(hourly[37])
    @hour_39 = HourWeather.new(hourly[38])
    @hour_40 = HourWeather.new(hourly[39])
    @hour_41 = HourWeather.new(hourly[40])
    @hour_42 = HourWeather.new(hourly[41])
    @hour_43 = HourWeather.new(hourly[42])
    @hour_44 = HourWeather.new(hourly[43])
    @hour_45 = HourWeather.new(hourly[44])
    @hour_46 = HourWeather.new(hourly[45])
    @hour_47 = HourWeather.new(hourly[46])
    @hour_48 = HourWeather.new(hourly[47])
  end
end

class HourWeather

  attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :pressure, 
  :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, 
  :wind_gust, :main, :description, :icon, :rain, :snow

  def initialize(data)
    sort_data(data)
    process_data
  end

  def sort_data(data)
    @dt          = data['dt']
    @temp        = data['temp']
    @feels_like  = data['feels_like']
    @pressure    = data['pressure']
    @humidity    = data['humidity']
    @dew_point   = data['dew_point']
    @clouds      = data['clouds']
    @visibility  = data['visibility']
    @wind_speed  = data['wind_speed']
    @wind_gust   = data['wind_gust']
    @wind_deg    = data['wind_deg']
    @main        = data['weather'].first['main']
    @description = data['weather'].first['description']
    @icon        = data['weather'].first['icon']
    @rain        = data['rain'] if data['rain']
    @snow        = data['snow']['1h'] if data['snow']
  end

  def process_data
    @date        = Time.at(@dt).strftime('%-d.%m %R')
    @temp        = @temp.round.to_s + "\u00B0" + 'C'
    @feels_like  = @feels_like.round.to_s + "\u00B0" + 'C'
    @pressure    = @pressure.to_s + ' мм рт. ст.' 
    @humidity    = @humidity.to_s + '%'
    @clouds      = @clouds.to_s + '%'
    @visibility  = @visibility.to_s + ' м' if @visibility
    @wind_speed  = @wind_speed.to_s + ' м/с'
    @wind_gust   = @wind_gust.to_s + ' м/с' if @wind_gust
    @rain        = @rain.to_s + ' мм' if @rain
    @snow        = @snow.to_s + ' мм' if @snow
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
    @main = case @main
            when 'Thunderstorm'
              'Гроза'
            when 'Drizzle'
              'Морось'
            when 'Rain'
              'Дождь'
            when 'Snow'
              'Снег'
            when 'Clear'
              'Ясно'
            when 'Clouds'
              'Облачно'
            when 'Mist'
              'Туман'
            when 'Smoke'
              'Дымка'
            when 'Haze'
              'Мгла'
            when 'Dust'
              'Пыль'
            when 'Fog'
              'Туман'
            when 'Squall'
              'Шквал'
            when 'Ash'
              'Пепел'
            when 'Tornado'
              'Торнадо'
            end
    @description = @description.capitalize
  end
end

class DailyWeather < HourWeather

  attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :pressure, 
  :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, 
  :wind_gust, :main, :description, :icon, :rain, :snow, :temp_day, :temp_min,
  :temp_max, :temp_night, :temp_eve, :temp_morn

  def initialize(data)
    super
  end

  def sort_data(data)
    super
    @sunrise     = data['sunrise']
    @sunset      = data['sunset']
    @temp_day    = data['temp']['day']
    @temp_min    = data['temp']['min']
    @temp_max    = data['temp']['max']
    @temp_night  = data['temp']['night']
    @temp_eve    = data['temp']['eve']
    @temp_morn   = data['temp']['morn']
    @dew_point   = data['dew_point']
    @uvi         = data['uvi']
  end

  def process_data
    @date       = Time.at(@dt).strftime('%-d.%m')
    @sunrise    = Time.at(@sunrise).strftime('%R') if @sunrise
    @sunset     = Time.at(@sunset).strftime('%R') if @sunset
    @temp_day   = @temp_day.round.to_s + "\u00B0" + 'C'
    @temp_min   = @temp_min.round.to_s + "\u00B0" + 'C'
    @temp_max   = @temp_max.round.to_s + "\u00B0" + 'C'
    @temp_night = @temp_night.round.to_s + "\u00B0" + 'C'
    @temp_eve   = @temp_eve.round.to_s + "\u00B0" + 'C' 
    @temp_morn  = @temp_morn.round.to_s + "\u00B0" + 'C'
    @dew_point  = @dew_point.round.to_s + "\u00B0" + 'C' if @dew_point    
    @pressure   = @pressure.to_s + ' мм рт. ст.' 
    @humidity   = @humidity.to_s + '%'
    @clouds     = @clouds.to_s + '%'
    @visibility = @visibility.to_s + ' м' if @visibility
    @wind_speed = @wind_speed.to_s + ' м/с'
    @wind_gust  = @wind_gust.to_s + ' м/с' if @wind_gust
    @rain       = @rain.to_s + ' мм' if @rain
    @snow       = @snow.to_s + ' мм' if @snow
    @wind_deg   = case @wind_deg.to_i
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
    @main = case @main
            when 'Thunderstorm'
              'Гроза'
            when 'Drizzle'
              'Морось'
            when 'Rain'
              'Дождь'
            when 'Snow'
              'Снег'
            when 'Clear'
              'Ясно'
            when 'Clouds'
              'Облачно'
            when 'Mist'
              'Туман'
            when 'Smoke'
              'Дымка'
            when 'Haze'
              'Мгла'
            when 'Dust'
              'Пыль'
            when 'Fog'
              'Туман'
            when 'Squall'
              'Шквал'
            when 'Ash'
              'Пепел'
            when 'Tornado'
              'Торнадо'
            end
    @description = @description.capitalize
  end
end


class CurrentWeather < HourWeather

  attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :pressure, 
  :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, 
  :wind_gust, :main, :description, :icon, :rain, :snow, :dt

  def initialize(data)
    super
  end

  def sort_data(data)
    super
    @sunrise     = data['sunrise']
    @sunset      = data['sunset']
    @dew_point   = data['dew_point']
    @uvi         = data['uvi']
  end

  def process_data
    super
    @sunrise     = Time.at(@sunrise).strftime('%R') if @sunrise
    @sunset      = Time.at(@sunset).strftime('%R') if @sunset    
    @dew_point   = @dew_point.round.to_s + "\u00B0" + 'C' if @dew_point    
  end
end




