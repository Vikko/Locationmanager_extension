require 'rho/rhocontroller'

class SingleController < Rho::RhoController
  @layout = :simplelayout
  
  @@heading = 0.0
  @@distance = 100.0
  @@lat = 0.0
  @@long = 0.0
  @@goal_lat = 0.0
  @@goal_long = 0.0
  @@earth_radius = 6368500.0
  
  PI = 3.141592653589793

  def index
    get_location
    render :back => '/app'  
  end
  
  def get_location
    @@lat = 51.989610003665305#GeoLocation.latitude # 51.989610003665305   
    @@long = 4.344027028600576#GeoLocation.longitude # 4.344027028600576
  end
  
  def calculate
    get_location
#    if GeoLocation.known_position? 
      heading_in_rad = deg_to_rad(@@heading)
      lat_in_rad = deg_to_rad(@@lat)
      long_in_rad = deg_to_rad(@@long)
      @lat = @@lat
      @long = @@long
      @heading = @@heading
      @distance = @@distance
      @earth = @@earth_radius
      lat_component1 = (Math.sin(lat_in_rad) * Math.cos(@@distance / @@earth_radius))
      lat_component2 = (Math.cos(lat_in_rad) * Math.sin(@@distance / @@earth_radius) * Math.cos(heading_in_rad))
      @@goal_lat = Math.asin(lat_component1 + lat_component2)
      long_component1 = (Math.sin(heading_in_rad) * Math.sin(@@distance / @@earth_radius) * Math.cos(lat_in_rad))
      long_component2 = (Math.cos(@@distance / @@earth_radius) - Math.sin(lat_in_rad) * Math.sin(@@goal_lat))
      @@goal_long = long_in_rad + Math.atan2( long_component1, long_component2 )
      @goal_lat = rad_to_deg(@@goal_lat)
      @goal_long = rad_to_deg(@@goal_long)
#    end
    set_vars
    render :action => :submit
  end 
  
  def update
    get_location
    dLat = (@@goal_lat - deg_to_rad(@@lat))
    dLong = (@@goal_long - deg_to_rad(@@long))  
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.sin(dLong/2) * Math.sin(dLong/2) * Math.cos(deg_to_rad(@@lat)) * Math.cos(@@goal_lat); 
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    @@distance = @@earth_radius * c;
    y = Math.sin(dLong) * Math.cos(@@goal_lat);
    x = Math.cos(deg_to_rad(@@lat))*Math.sin(@@goal_lat) -
            Math.sin(deg_to_rad(@@lat))*Math.cos(@@goal_lat)*Math.cos(dLong);
    @@heading = (360 + rad_to_deg(Math.atan2(y, x))) % 360;
    set_vars 
    render :partial => "information"
  end

  def set_vars
    @lat = @@lat
    @long = @@long
    @heading = @@heading
    @distance = @@distance
    @earth = @@earth_radius
    @goal_lat = rad_to_deg(@@goal_lat)
    @goal_long = rad_to_deg(@@goal_long)
  end
  
  def deg_to_rad(deg)
    rad = (PI * (deg % 360.0) / 180) 
    return rad
  end
  
  def rad_to_deg(rad)
    deg = ((180 * rad) / PI )
    return deg
  end
  
  def set_distance
    @@distance = @params["distance"].to_f
    @@heading = @params["heading"].to_f
#    Alert.show_popup(
#                     :message=>"Current distance: "+ @@distance.to_s + "\nCurrent heading: " + @@heading.to_s,
#                     :title=>"Goal updated",
#                     :buttons => ["Ok"]
#               )
    redirect :action => :calculate
  end
end