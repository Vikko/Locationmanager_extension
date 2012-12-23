require 'rho/rhocontroller'
require 'helpers/browser_helper'

class HoleController < Rho::RhoController
  include BrowserHelper

  # GET /Hole
  def index
    @holes = Hole.find(:all)
    render :back => '/app'
  end

  # GET /Hole/{1}
  def show
    @hole = Hole.find(@params['id'])
    if @hole
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Hole/new
  def new
    @@course ||= Course.find(@params["course"])
    @course = @@course
    hole_nr = @params["hole_nr"] ? @params["hole_nr"].to_i : (@course.get_holes.size + 1)
    @hole = Hole.new(:hole_nr => (hole_nr))
    if @course.holes_count != nil && hole_nr > @course.holes_count.to_i
      redirect "/app/Scorecard"
    else
      render :action => :new, :back => '/app'
    end
  end

  # GET /Hole/{1}/edit
  def edit
    @hole = Hole.find(@params['id'])
    if @hole
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Hole/create
  def create
    @hole = Hole.create(@params['hole'])
    redirect :action => :index
  end
  
  def create_hole
     @old_courses = Course.find(:all, :conditions => ["temp = 1"])
     @old_courses.each do |course|
       course.delete
     end    
     @old_holes = Hole.find(:all, :conditions => ["temp = 1"])
     @old_holes.each do |hole|
       hole.delete
     end
     @course = @@course
     if @params["hole"]["hole_nr"]
       hole_nr = @params["hole"]["hole_nr"].to_i
     else
       hole_nr = 1
     end
     get_location
     @@hole = Hole.create(:start_lat => @@lat, :start_long => @@long, :distance => @params["hole"]["distance"].to_f, :heading => @params["hole"]["heading"].to_f, :par => @params["hole"]["par"].to_i, :course_id => @@course.object, :hole_nr => hole_nr, :temp => false);
     @hole = @@hole
     if @@hole.valid? 
       calculate
     end
     redirect :action => :swing_input
   end
  
  # POST /Hole/{1}/update
  def update
    @hole = Hole.find(@params['id'])
    @hole.update(@params['hole']) if @hole
    redirect :action => :index
  end

  # POST /Hole/{1}/delete
  def delete
    @hole = Hole.find(@params['id'])
    @hole.destroy if @hole
    redirect :action => :index  
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
  
  def set_vars
    @lat = @@lat
    @long = @@long
    @hole = @@hole
  end  
  
  def swing_input
    calculate
    @course = @@course
    render :action => :swing_input    
  end
  
  def add_swing
    @@hole.add_swing
    @swings = @@hole.get_swings
    render :partial => "swings"
  end
  
  def update_heading_distance
    get_location
    @distance, @heading = @@hole.update(@@lat, @@long)
    set_vars 
    render :partial => "information"
  end 
end
