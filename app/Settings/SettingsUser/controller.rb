require 'rho/rhocontroller'

class SettingsUserController < Rho::RhoController
  
  def index
    @msg = @params['msg']
    render
  end
end
