class Town < ActiveRecord::Base
  before_validation :geocode
  
    def toCelsus(fTemp)
      if fTemp
        return (fTemp - 32.0) * 5.0 / 9.0
      else
        return nil
      end
    end
  
  def getForecastweather
     forecast = ForecastIO.forecast(self.latitude, self.longitude)
     temperatureOk = false
     weatherOk = false
     if forecast
       todayForecast = forecast.currently
       if todayForecast
         if todayForecast.temperature
           temperature = self.toCelsus(todayForecast.temperature)
           temperatureOk = true
         end
         if todayForecast.summary
           weather = todayForecast.summary
           weatherOk = true
         end
       end
     end
     if !temperatureOk
       temperature = "Unavailable"
     end
     if !weatherOk
      weather = "Unavailable"
     end
     return { "weather" => weather, "temperature" => temperature}
  end
  
  
    def getTemperature
     forecast = ForecastIO.forecast(self.latitude, self.longitude)
     temperatureOk = false
     if forecast
       todayForecast = forecast.currently
       if todayForecast
         if todayForecast.temperature
           return self.toCelsus(todayForecast.temperature)
           temperatureOk = true
         end
       end
     end
     if !temperatureOk
       return "Unavailable"
     end
      
  end
  
  def getWeather
     forecast = ForecastIO.forecast(self.latitude, self.longitude)
     weatherOk = false
     if forecast
       todayForecast = forecast.currently
       if todayForecast
         if todayForecast.summary
           return todayForecast.summary
           weatherOk = true
         end
       end
     end
     if !weatherOk
      return "Unavailable"
     end
  end
  
  private
  def geocode
    
    places = Nominatim.search(self.name).limit(1)
    if places.first
      place = places.first
      self.latitude = place.latitude
      self.longitude = place.longitude
    end
  end
end
