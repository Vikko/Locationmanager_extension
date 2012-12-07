class Hole
  include Rhom::FixedSchema
  property :swing_count, :integer
  property :course_id, :integer
  property :start_lat, :float
  property :start_long, :float
  property :goal_lat, :float
  property :goal_long, :float
  property :par, :integer
  property :distance, :float
  property :heading, :float
  
  EARTHRADIUS = 6368500.0
  PI = 3.141592653589793
  
  def course
    Course.find(self.course_id)
  end
  
  def valid?
    return (self.start_lat != nil && self.start_long != nil && self.heading != nil && self.distance != nil)
  end
  
  def get_swings
    Swing.find(:all).where("hole_id = ?", self.id)
  end
  
  def calculate
    heading_in_rad = deg_to_rad(self.heading)
    lat_in_rad = deg_to_rad(self.start_lat)
    long_in_rad = deg_to_rad(self.start_long)

    lat_component1 = (Math.sin(lat_in_rad) * Math.cos(self.distance / EARTHRADIUS))
    lat_component2 = (Math.cos(lat_in_rad) * Math.sin(self.distance / EARTHRADIUS) * Math.cos(heading_in_rad))
    self.goal_lat = Math.asin(lat_component1 + lat_component2)
    long_component1 = (Math.sin(heading_in_rad) * Math.sin(self.distance / EARTHRADIUS) * Math.cos(lat_in_rad))
    long_component2 = (Math.cos(self.distance / EARTHRADIUS) - Math.sin(lat_in_rad) * Math.sin(self.goal_lat))
    self.goal_long = long_in_rad + Math.atan2( long_component1, long_component2 )
    self.goal_lat = rad_to_deg(self.goal_lat)
    self.goal_long = rad_to_deg(self.goal_long)
  end
  
  def update(lat, long)
     dLat = (deg_to_rad(lat) - deg_to_rad(self.goal_lat))
     dLong = (deg_to_rad(long) - deg_to_rad(self.goal_long))  
     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
             Math.sin(dLong/2) * Math.sin(dLong/2) * Math.cos(deg_to_rad(lat)) * Math.cos(self.goal_lat); 
     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
     distance = EARTHRADIUS * c;
     y = Math.sin(dLong) * Math.cos(self.goal_lat);
     x = Math.cos(deg_to_rad(lat))*Math.sin(self.goal_lat) -
             Math.sin(deg_to_rad(lat))*Math.cos(self.goal_lat)*Math.cos(dLong);
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
