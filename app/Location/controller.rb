require 'rho/rhocontroller'
require 'helpers/application_helper'
require 'helpers/browser_helper'
require 'locationmanager'

class LocationController < Rho::RhoController
  @layout = :simplelayout
  
  def index
    render :back => '/app'  
  end
  
  def get_heading
    @response['headers']['Content-Type']='application/json;' 
    data = Locationmanager::Base::get_heading
    x, y, z, th = data
    result = '{"heading": ' + th.to_s + '}'
    render :string => result, :use_layout_on_ajax => true
  end
  
end