require 'rho/rhocontroller'

class SingleController < Rho::RhoController
  @layout = :simplelayout
  
  @@heading = 0.0
  @@distance = 0.0
  
  PI = 3.141592653589793

  def index
    render :back => '/app'  
  end
  
  def start
#    if GeoLocation.known_position? 
      @@heading = 0.0 #Locationmanager::Base::get_heading[4]
      @@distance = 100.0 #meter
      lat = 3.344027028600576 #GeoLocation.latitude
      long = 52.989610003665305 #GeoLocation.longitude
      earth_radius = 6368500.0
      heading_in_rad = (@@heading%360)*(PI/180)
      lat_in_rad = deg_to_rad(lat)
      long_in_rad = deg_to_rad(long)
      @lat = lat_in_rad
      @long = long_in_rad
      @heading = heading_in_rad
      @distance = @@distance
      @earth = earth_radius
      @lat_component1 = (Math.sin(lat_in_rad) * Math.cos(@@distance / earth_radius))
      @lat_component2 = (Math.cos(lat_in_rad) * Math.sin(@@distance / earth_radius) * Math.cos(heading_in_rad))
      @goal_lat = Math.asin( @lat_component1 + @lat_component2)
      @goal_long = long_in_rad + Math.atan2((Math.sin(heading_in_rad) * Math.sin(@@distance / earth_radius) * Math.cos(lat_in_rad)), (Math.cos(@@distance / earth_radius) - Math.sin(lat_in_rad) * Math.sin(@goal_lat)))
#    end
    render :start
  end 
  
  def stop
#    GeoLocation.turnoff
  end
  
  def deg_to_rad(deg)
    rad = (PI * (deg % 360.0) / 180) 
    return rad
  end
  
  def rad_to_deg(rad)
    deg = ((180 * rad) / PI )
    return deg
  end
  
  def get_heading
    x, y, z, heading = [0.0,0.0,0.0,0.0] #Locationmanager::Base::get_heading
    @heading = 0
    render :js
  end
end