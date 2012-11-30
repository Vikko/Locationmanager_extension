class Swing
  include Rhom::FixedSchema
  
  property :lat_start, :float
  property :long_start, :float
  property :lat_end, :float
  property :long_end, :float
  property :distance, :float
  property :heading, :float
  
  # property :hole_id, :integer
  belongs_to :hole_id, 'Hole'

  EARTHRADIUS = 6368500.0
  PI = 3.141592653589793
  
  def valid?
    return (self.lat_start != nil && self.long_start!= nil && self.heading != nil && self.distance != nil)
  end
  
  def endpoint?
    return (self.lat_end != nil && self.long_end!= nil)
  end
  
  def hole
    Hole.find(self.hole_id)
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
