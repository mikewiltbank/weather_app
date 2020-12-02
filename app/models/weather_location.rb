class WeatherLocation < ApplicationRecord

  validates_presence_of :name, :zip, :temp

  def updated_weather_info
    weather_client = Integrations::OpenWeather.new
    weather_data = weather_client.by_zipcode(self.zip)

    self.update(weather_data)
  end

  def calculate_average_temp
    (self.temp_max.to_f + self.temp_min.to_f) / 2
  end

end
