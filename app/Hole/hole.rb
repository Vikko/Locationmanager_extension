class Hole
  include Rhom::FixedSchema
  property :swing_count, :integer
  property :start_lat, :float
  property :start_long, :float
  property :goal_lat, :float
  property :goal_long, :float
  property :par, :integer
  property :distance, :float
  property :heading, :float
  property :course_id, :float
  property :temp, :boolean
  property :hole_nr, :integer
  
  belongs_to :course_id, 'Course'
  
  EARTHRADIUS = 6368500.0
  PI = 3.141592653589793
  
  def valid?
    return (self.start_lat != nil && self.start_long != nil && self.heading != nil && self.distance != nil)
  end
  
  def get_swings
    Swing.find(:all, :conditions => ["hole_id = ?", self.object])
  end
  
  def add_swing
    if (get_swings == [])
      lat_start, long_start = self.start_lat, self.start_long
    else
      last_swing = get_swings.last
      lat_start = last_swing.lat_end
      long_start = last_swing.long_end
    end
    lat_end, long_end = get_location 
    Swing.create(:lat_start => lat_start, :long_start => long_start, :lat_end => lat_end, :long_end => long_end, :hole_id => self.object)
  end
  
  def get_course
    Course.find(self.course_id)
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
     goal_lat = deg_to_rad(self.goal_lat)
     goal_long = deg_to_rad(self.goal_long)
     dLat = (goal_lat - deg_to_rad(lat))
     dLong = (goal_long - deg_to_rad(long))  
     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
             Math.sin(dLong/2) * Math.sin(dLong/2) * Math.cos(deg_to_rad(lat)) * Math.cos(goal_lat); 
     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
     distance = EARTHRADIUS * c;
     y = Math.sin(dLong) * Math.cos(goal_lat);
     x = Math.cos(deg_to_rad(lat))*Math.sin(goal_lat) -
             Math.sin(deg_to_rad(lat))*Math.cos(goal_lat)*Math.cos(dLong);
     heading = (360 + rad_to_deg(Math.atan2(y, x))) % 360;
     return [distance, heading]
   end
   
   def deg_to_rad(deg)
     rad = (PI * (deg  % 360.0) / 180) 
     return rad
   end

   def rad_to_deg(rad)
     deg = ((180 * rad) / PI )
     return deg
   end
   
   def get_location
     lat = 51.989610003665305
     long = 4.344027028600576
     if GeoLocation.known_position? 
       long = GeoLocation.longitude
       lat = GeoLocation.latitude
     end
     return [lat, long]
   end
  
end
