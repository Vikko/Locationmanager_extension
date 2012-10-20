require 'rho/rhocontroller'
require 'helpers/application_helper'
require 'helpers/browser_helper'
require 'accelerometer'

class AccelerometerTestController < Rho::RhoController
  include BrowserHelper
  include ApplicationHelper
  
  def index
    Accelerometer::Base::start
    render :back => '/app'
  end

  def get_xyz
    @response['headers']['Content-Type']='application/json;' 
    data = Accelerometer::Base::get_readings
    x, y, z = data
    app_info("Get Readings: "+data.to_s)
    app_info("xyz: "+x.to_s+","+y.to_s+"z"+z.to_s)
    result = '{"x": ' + x.to_s + ',"y": ' + y.to_s + ', "z": ' + z.to_s + '}'
    render :string => result, :use_layout_on_ajax => true
  end
  
end
