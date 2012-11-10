require 'rho/rhocontroller'
require 'helpers/application_helper'
require 'helpers/browser_helper'
require 'locationmanager'


class LocationmanagerTestController < Rho::RhoController
  include BrowserHelper
  include ApplicationHelper
  
  def index
    render :back => '/app'
  end

  def get_xyzth
    @response['headers']['Content-Type']='application/json;' 
   data = Locationmanager::Base::get_heading
    x, y, z, th = data
   app_info("Get Readings: "+data.to_s)
   app_info("x y z mag: "+x.to_s+","+y.to_s+","+z.to_s+","+th.to_s)
    result = '{"x": ' + x.to_s + ',"y": ' + y.to_s + ', "z": ' + z.to_s + ', "th": ' + th.to_s + '}'
    render :string => result, :use_layout_on_ajax => true
  end
  
end
