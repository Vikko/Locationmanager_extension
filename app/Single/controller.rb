require 'rho/rhocontroller'

class SingleController < Rho::RhoController
  def index
    get_location
    render :back => '/app'  
  end
  
  def get_location
    @@lat = 51.989610003665305
    @@long = 4.344027028600576
    if GeoLocation.known_position? 
      @@long = GeoLocation.longitude
      @@lat = GeoLocation.latitude
    end
  end
  
  def calculate
    get_location
    if @@hole != nil && @@hole.valid?
      @@hole.calculate
    end 
    set_vars
    render :action => :submit
  end 
  
  def update
    get_location
    @@hole.update(@@lat, @@long)
    @distance = @@hole.distance
    @heading = @@hole.heading
    set_vars 
    render :partial => "information"
  end

  def set_vars
    @lat = @@lat
    @long = @@long
    @hole = @@hole
  end
  
  def set_distance
    @@hole = Hole.create(:start_lat => @@lat, :start_long => @@long, :distance => @params["distance"].to_f, :heading => @params["heading"].to_f, :par => @params["par"].to_i);
    if @@hole.valid? 
      calculate
    end
  end
end