require "net/http"
require "uri"

require_relative 'classes.rb'

city_weather = WeatherForecast.new(55.82, 37.66, '1c501cf2fe713fa399e0cd06c5258e4d')

puts "Погода в Москве (Алексеевский р-н) на #{city_weather.current.date}:

#{city_weather.current.main}, #{city_weather.current.description}; Облачность: #{city_weather.current.clouds}
Температура #{city_weather.current.temp}, ощущается как #{city_weather.current.feels_like}.
Относительная влажность #{city_weather.current.humidity}
Ветер #{city_weather.current.wind_deg} #{city_weather.current.wind_speed}
Давление #{city_weather.current.pressure}
УФ индекс #{city_weather.current.uvi}
Восход в #{city_weather.current.sunrise}, закат в #{city_weather.current.sunset}

Прогноз на #{city_weather.hour_4.date}

#{city_weather.hour_4.main}, #{city_weather.hour_4.description}; Облачность: #{city_weather.hour_4.clouds}
Температура #{city_weather.hour_4.temp}, ощущается как #{city_weather.hour_4.feels_like}.
Относительная влажность #{city_weather.hour_4.humidity}
Ветер #{city_weather.hour_4.wind_deg} #{city_weather.hour_4.wind_speed}

Прогноз на #{city_weather.hour_8.date}

#{city_weather.hour_8.main}, #{city_weather.hour_8.description}; Облачность: #{city_weather.hour_8.clouds}
Температура #{city_weather.hour_8.temp}, ощущается как #{city_weather.hour_8.feels_like}.
Относительная влажность #{city_weather.hour_8.humidity}
Ветер #{city_weather.hour_8.wind_deg} #{city_weather.hour_8.wind_speed}

Прогноз на #{city_weather.hour_12.date}

#{city_weather.hour_12.main}, #{city_weather.hour_12.description}; Облачность: #{city_weather.hour_12.clouds}
Температура #{city_weather.hour_12.temp}, ощущается как #{city_weather.hour_12.feels_like}.
Относительная влажность #{city_weather.hour_12.humidity}
Ветер #{city_weather.hour_12.wind_deg} #{city_weather.hour_12.wind_speed} "

