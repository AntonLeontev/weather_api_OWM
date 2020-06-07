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
  :hour_43, :hour_44, :hour_45, :hour_46, :hour_47, :hour_48

  def initialize(lat, lon, appid)
    data = take_data(lat, lon, appid)
    split_data(data)
  end

  def take_data(lat, lon, appid)
    uri = URI.parse("https://api.openweathermap.org/data/2.5/onecall" + 
      "?lat=#{lat}&lon=#{lon}&lang=ru&units=metric&exclude=minutely&appid=#{appid}")
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def split_data(data)
    doc    = JSON.parse(data)
    hourly = doc['hourly']
    daily  = doc['daily']

    @current = HourWeather.new(doc['current'])
    @hour_1  = HourWeather.new(doc['hourly'][0])
    @hour_2  = HourWeather.new(doc['hourly'][1])
    @hour_3  = HourWeather.new(doc['hourly'][2])
    @hour_4  = HourWeather.new(doc['hourly'][3])
    @hour_5  = HourWeather.new(doc['hourly'][4])
    @hour_6  = HourWeather.new(doc['hourly'][5])
    @hour_7  = HourWeather.new(doc['hourly'][6])
    @hour_8  = HourWeather.new(doc['hourly'][7])
    @hour_9  = HourWeather.new(doc['hourly'][8])
    @hour_10 = HourWeather.new(doc['hourly'][9])
    @hour_11 = HourWeather.new(doc['hourly'][10])
    @hour_12 = HourWeather.new(doc['hourly'][11])
    @hour_13 = HourWeather.new(doc['hourly'][12])
    @hour_14 = HourWeather.new(doc['hourly'][13])
    @hour_15 = HourWeather.new(doc['hourly'][14])
    @hour_16 = HourWeather.new(doc['hourly'][15])
    @hour_17 = HourWeather.new(doc['hourly'][16])
    @hour_18 = HourWeather.new(doc['hourly'][17])
    @hour_19 = HourWeather.new(doc['hourly'][18])
    @hour_20 = HourWeather.new(doc['hourly'][19])
    @hour_21 = HourWeather.new(doc['hourly'][20])
    @hour_22 = HourWeather.new(doc['hourly'][21])
    @hour_23 = HourWeather.new(doc['hourly'][22])
    @hour_24 = HourWeather.new(doc['hourly'][23])
    @hour_25 = HourWeather.new(doc['hourly'][24])
    @hour_26 = HourWeather.new(doc['hourly'][25])
    @hour_27 = HourWeather.new(doc['hourly'][26])
    @hour_28 = HourWeather.new(doc['hourly'][27])
    @hour_29 = HourWeather.new(doc['hourly'][28])
    @hour_30 = HourWeather.new(doc['hourly'][29])
    @hour_31 = HourWeather.new(doc['hourly'][30])
    @hour_32 = HourWeather.new(doc['hourly'][31])
    @hour_33 = HourWeather.new(doc['hourly'][32])
    @hour_34 = HourWeather.new(doc['hourly'][33])
    @hour_35 = HourWeather.new(doc['hourly'][34])
    @hour_36 = HourWeather.new(doc['hourly'][35])
    @hour_37 = HourWeather.new(doc['hourly'][36])
    @hour_38 = HourWeather.new(doc['hourly'][37])
    @hour_39 = HourWeather.new(doc['hourly'][38])
    @hour_40 = HourWeather.new(doc['hourly'][39])
    @hour_41 = HourWeather.new(doc['hourly'][40])
    @hour_42 = HourWeather.new(doc['hourly'][41])
    @hour_43 = HourWeather.new(doc['hourly'][42])
    @hour_44 = HourWeather.new(doc['hourly'][43])
    @hour_45 = HourWeather.new(doc['hourly'][44])
    @hour_46 = HourWeather.new(doc['hourly'][45])
    @hour_47 = HourWeather.new(doc['hourly'][46])
    @hour_48 = HourWeather.new(doc['hourly'][47])
  end

  class HourWeather

    attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :pressure, 
    :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, 
    :main, :description, :icon, :rain, :snow

    def initialize(data)
      sort_data(data)
      process_data
    end

    def sort_data(data)
      @date        = data['dt']
      @sunrise     = data['sunrise']
      @sunset      = data['sunset']
      @temp        = data['temp']
      @feels_like  = data['feels_like']
      @pressure    = data['pressure']
      @humidity    = data['humidity']
      @dew_point   = data['dew_point']
      @uvi         = data['uvi']
      @clouds      = data['clouds']
      @visibility  = data['visibility']
      @wind_speed  = data['wind_speed']
      @wind_deg    = data['wind_deg']
      @main        = data['weather'].first['main']
      @description = data['weather'].first['description']
      @icon        = data['weather'].first['icon']
      @rain        = data['rain']['1h'] if data['rain']
      @snow        = data['snow']['1h'] if data['snow']
    end

    def process_data
      @date        = Time.at(@date).strftime('%-d.%m %R')
      @sunrise     = Time.at(@sunrise).strftime('%R') if @sunrise
      @sunset      = Time.at(@sunset).strftime('%R') if @sunset
      @temp        = @temp.round.to_s + "\u00B0" + 'C'
      @feels_like  = @feels_like.round.to_s + "\u00B0" + 'C'
      @pressure    = @pressure.to_s + ' мм рт. ст.' 
      @humidity    = @humidity.to_s + '%'
      @dew_point   = @dew_point.round.to_s + "\u00B0" + 'C' if @dew_point
      @clouds      = @clouds.to_s + '%'
      @visibility  = @visibility.to_s + ' м' if @visibility
      @wind_speed  = @wind_speed.to_s + ' м/с'
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
    end
  end
end
