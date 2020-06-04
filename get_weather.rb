require "net/http"
require "uri"

require_relative 'classes.rb'

msc = Weather.new(55.82, 37.656946, '1c501cf2fe713fa399e0cd06c5258e4d')

puts "Погода в Москве (Алексеевский р-н) на #{msc.date}:

#{msc.main}
Температура #{msc.temp}, ощущается как #{msc.feels_like}
Относительная влажность #{msc.humidity}
Ветер #{msc.wind_deg} #{msc.wind_speed}
Восход в #{msc.sunrise}, закат в #{msc.sunset}"

