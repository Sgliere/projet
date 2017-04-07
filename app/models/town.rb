class Town < ActiveRecord::Base
  before_validation :geocode
  
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
