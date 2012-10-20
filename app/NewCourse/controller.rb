require 'rho/rhocontroller'

class NewCourseController < Rho::RhoController
  @layout = :simplelayout
  
  def index
    render :back => '/app'  
  end
  
  def get_json
    @response['headers']['Content-Type']='application/json;' 
    result = '{"x": 1, "y": 2, "z": 2}' 
    render :string => result, :use_layout_on_ajax => true
  end
  
end