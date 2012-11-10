require 'rho/rhocontroller'

class NewCourseController < Rho::RhoController
  @layout = :simplelayout
  
  def index
    render :back => '/app'  
  end

  def new_course
    render :string => @params.to_s 
  end
  
end