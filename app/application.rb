require 'rho/rhoapplication'
# require 'locationmanager'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    
    # Locationmanager::Base::init
    #To remove default toolbar uncomment next line:
    @@toolbar = nil
    # [
    #       {:action => :separator},
    #       {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'},
    #       {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'},
    #       {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'}
    #     ]
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    #SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
  end
end
