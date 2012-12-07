require 'rho/rhocontroller'

class SettingsApplicationController < Rho::RhoController
  
  def index
    @msg = @params['msg']
    render
  end
end
