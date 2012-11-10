require 'rho/rhocontroller'

class SingleController < Rho::RhoController
  @layout = :simplelayout
  
  @@heading = 0.0
  @@distance = 100.0
  @@lat = 0.0
  @@long = 0.0
  @@earth_radius = 6368500.0
  
  PI = 3.141592653589793

  def index
    @@lat = GeoLocation.latitude # 52.989610003665305   
    @@long = GeoLocation.longitude # 3.344027028600576
    render :back => '/app'  
  end
  
  def result
#    if GeoLocation.known_position? 
      heading_in_rad = deg_to_rad(@@heading)
      lat_in_rad = deg_to_rad(@@lat)
      long_in_rad = deg_to_rad(@@long)
      @lat = lat
      @long = long
      @heading = heading_in_rad
      @distance = @@distance
      @earth = earth_radius
      lat_component1 = (Math.sin(lat_in_rad) * Math.cos(@@distance / earth_radius))
      lat_component2 = (Math.cos(lat_in_rad) * Math.sin(@@distance / earth_radius) * Math.cos(heading_in_rad))
      goal_lat = Math.asin(lat_component1 + lat_component2)
      long_component1 = (Math.sin(heading_in_rad) * Math.sin(@@distance / earth_radius) * Math.cos(lat_in_rad))
      long_component2 = (Math.cos(@@distance / earth_radius) - Math.sin(lat_in_rad) * Math.sin(goal_lat))
      goal_long = long_in_rad + Math.atan2( long_component1, long_component2 )
      @goal_lat = rad_to_deg(goal_lat)
      @goal_long = rad_to_deg(goal_long)
#    end
  end 

  
  def deg_to_rad(deg)
    rad = (PI * (deg % 360.0) / 180) 
    return rad
  end
  
  def rad_to_deg(rad)
    deg = ((180 * rad) / PI )
    return deg
  end
  
  def update_distance
    @@distance = @params[:distance_input].to_f
    render :string => "ok"
  end
  
  def update_heading
    @@heading = @params[:heading_input].to_f
    render :string => "ok"
  end
  
  def submit
    result
    render :submit
  end
end