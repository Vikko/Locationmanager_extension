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
    @distance = @@hole.distance
    @heading = @@hole.heading
    set_vars
    render :action => :submit
  end 
  
  def add_swing
    @@hole.add_swing
    @swings = @@hole.get_swings
    render :partial => "swings"
  end
  
  def update
    get_location
    @distance, @heading = @@hole.update(@@lat, @@long)
    set_vars 
    render :partial => "information"
  end

  def set_vars
    @lat = @@lat
    @long = @@long
    @hole = @@hole
  end
  
  def set_distance
    @old_courses = Course.find(:all, :conditions => ["temp = 1"])
    @old_courses.each do |course|
      course.delete
    end    
    @old_holes = Hole.find(:all, :conditions => ["temp = 1"])
    @old_holes.each do |hole|
      hole.delete
    end
    @@course = Course.create(:club_name => "", :course_name => "Single distance", :holes_count => 1, :temp => true)
    @@hole = Hole.create(:start_lat => @@lat, :start_long => @@long, :distance => @params["distance"].to_f, :heading => @params["heading"].to_f, :par => @params["par"].to_i, :course_id => @@course.object, :hole_nr => 1, :temp => true);

    if @@hole.valid? 
      calculate
    end
  end
end