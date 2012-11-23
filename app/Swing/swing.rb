# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Swing
  include Rhom::FixedSchema
  
  property :lat_start, :float
  property :long_start, :float
  property :lat_end, :float
  property :long_end, :float
  property :distance, :float
  property :heading, :float

  EARTHRADIUS = 6368500.0
  PI = 3.141592653589793
  
  def calculate
   if (self.lat_start != nil && self.long_start!= nil && self.heading != nil)
      heading_in_rad = deg_to_rad(self.heading)
      lat_in_rad = deg_to_rad(self.lat_start)
      long_in_rad = deg_to_rad(self.long_start)

      lat_component1 = (Math.sin(lat_in_rad) * Math.cos(self.distance / EARTHRADIUS))
      lat_component2 = (Math.cos(lat_in_rad) * Math.sin(self.distance / EARTHRADIUS) * Math.cos(heading_in_rad))
      self.lat_end = Math.asin(lat_component1 + lat_component2)
      long_component1 = (Math.sin(heading_in_rad) * Math.sin(self.distance / EARTHRADIUS) * Math.cos(lat_in_rad))
      long_component2 = (Math.cos(self.distance / EARTHRADIUS) - Math.sin(lat_in_rad) * Math.sin(self.lat_end))
      self.long_end = long_in_rad + Math.atan2( long_component1, long_component2 )
      self.lat_end = rad_to_deg(self.lat_end)
      self.long_end = rad_to_deg(self.long_end)
   end
  end
  
  def update(lat, long)
     dLat = (self.lat_end - deg_to_rad(lat))
     dLong = (self.long_end - deg_to_rad(long))  
     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
             Math.sin(dLong/2) * Math.sin(dLong/2) * Math.cos(deg_to_rad(lat)) * Math.cos(self.lat_end); 
     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
     distance = EARTHRADIUS * c;
     y = Math.sin(dLong) * Math.cos(self.lat_end);
     x = Math.cos(deg_to_rad(lat))*Math.sin(self.lat_end) -
             Math.sin(deg_to_rad(lat))*Math.cos(self.lat_end)*Math.cos(dLong);
     heading = (360 + rad_to_deg(Math.atan2(y, x))) % 360;
     return [distance, heading]
   end
  
   def deg_to_rad(deg)
     rad = (PI * (deg % 360.0) / 180) 
     return rad
   end

   def rad_to_deg(rad)
     deg = ((180 * rad) / PI )
     return deg
   end
  
  
end
