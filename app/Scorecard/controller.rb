require 'rho/rhocontroller'

class ScorecardController < Rho::RhoController
  
  def index
    if @params["course"]
      @course = Course.find(@params["course"])    
    else
      @course = Course.find(:all).last
    end
    @holes = @course.get_holes if @course
  end  
end
