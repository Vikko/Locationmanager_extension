require 'rho/rhocontroller'

class SingleController < Rho::RhoController
  @@swing = nil
  @@lat = 0.0
  @@long = 0.0

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
    if @@swing != nil && @@swing.valid?
      @@swing.calculate
    end 
    set_vars
    render :action => :submit
  end 
  
  def update
    get_location
    if @@swing.endpoint?
      @distance, @heading = @@swing.update(@@lat, @@long)
    end
    set_vars 
    render :partial => "information"
  end

  def set_vars
    @lat = @@lat
    @long = @@long
    @swing = @@swing
  end
  
  def set_distance
    @@swing = Swing.create(:lat_start => @@lat, :long_start => @@long, :distance => @params["distance"].to_f, :heading => @params["heading"].to_f);
    if @@swing.valid? 
      calculate
    end
  end
end