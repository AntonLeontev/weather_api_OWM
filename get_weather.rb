require "net/http"
require "uri"

require_relative 'classes.rb'

city_weather = WeatherForecast.new(55.82, 37.66, '1c501cf2fe713fa399e0cd06c5258e4d')

puts "Погода в Москве (Алексеевский р-н) на #{city_weather.current.date}:

#{city_weather.current.description}; Облачность: #{city_weather.current.clouds}
Температура #{city_weather.current.temp}, ощущается как #{city_weather.current.feels_like}.
Относительная влажность #{city_weather.current.humidity}
Ветер #{city_weather.current.wind_deg} #{city_weather.current.wind_speed}
Давление #{city_weather.current.pressure}
УФ индекс #{city_weather.current.uvi}
Восход в #{city_weather.current.sunrise}, закат в #{city_weather.current.sunset}

Прогноз на #{city_weather.hour_3.date}

#{city_weather.hour_3.description}; Облачность: #{city_weather.hour_3.clouds}
Температура #{city_weather.hour_3.temp}, ощущается как #{city_weather.hour_3.feels_like}.
Относительная влажность #{city_weather.hour_3.humidity}
Ветер #{city_weather.hour_3.wind_deg} #{city_weather.hour_3.wind_speed}

Прогноз на #{city_weather.hour_6.date}

#{city_weather.hour_6.description}; Облачность: #{city_weather.hour_6.clouds}
Температура #{city_weather.hour_6.temp}, ощущается как #{city_weather.hour_6.feels_like}.
Относительная влажность #{city_weather.hour_6.humidity}
Ветер #{city_weather.hour_6.wind_deg} #{city_weather.hour_6.wind_speed}

Прогноз на #{city_weather.hour_9.date}

#{city_weather.hour_9.description}; Облачность: #{city_weather.hour_9.clouds}
Температура #{city_weather.hour_9.temp}, ощущается как #{city_weather.hour_9.feels_like}.
Относительная влажность #{city_weather.hour_9.humidity}
Ветер #{city_weather.hour_9.wind_deg} #{city_weather.hour_9.wind_speed}
 "

puts "Прогноз на #{city_weather.day_2.date}"
puts
print "#{city_weather.day_2.description}. "
puts "Ожидается #{city_weather.day_2.rain} осадков" if city_weather.day_2.rain 
puts "Ожидается #{city_weather.day_2.snow} осадков" if city_weather.day_2.snow 
puts "Облачность: #{city_weather.day_2.clouds}
Температура: утром #{city_weather.day_2.temp_morn}, днем #{city_weather.day_2.temp_day}, вечером #{city_weather.day_2.temp_eve}, ночью #{city_weather.day_2.temp_night}.
Относительная влажность #{city_weather.day_2.humidity}
Ветер #{city_weather.day_2.wind_deg} #{city_weather.day_2.wind_speed}
УФ индекс #{city_weather.day_2.uvi}
Восход в #{city_weather.day_2.sunrise}, закат в #{city_weather.day_2.sunset} "

