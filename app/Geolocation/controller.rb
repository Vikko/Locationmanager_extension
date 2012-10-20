class GeolocationController < Rho::RhoController
  def print_location
    return
    puts "current_location: #{@params}"
    # do something on position changes
    #...
  end
end