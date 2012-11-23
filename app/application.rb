require 'rho/rhoapplication'
require 'rho/rhotabbar'
# require 'locationmanager'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    # @tabs = nil
    
    # Locationmanager::Base::init
    #To remove default toolbar uncomment next line:
    @tabs = nil
          # [
          # {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'},
          # {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'},
          # {:action => 'app/Single', :colored_icon => true, :icon => 'public/images/icons/single.png'}
          # ]
    Rho::NativeTabbar.create({
          :place_tabs_bottom => true,
          :tabs => [
            { :label => "Single", :action => '/app/Single', 
              :icon => "/public/images/icons/single.png", :reload => true, :colored_icon => true }, 
            { :label => "New Course",  :action => '/app/NewCourse',  
              :icon => "/public/images/icons/single.png", :reload => true, :colored_icon => true },
            { :label => "History",  :action => '/app/History',  
              :icon => "/public/images/icons/single.png", :reload => true, :colored_icon => true },
            { :label => "Scorecard",   :action => '/app/Scorecard', 
              :icon => "/public/images/icons/single.png", :reload => true, :colored_icon => true },
            { :label => "Settings",   :action => '/app/Settings', 
              :icon => "/public/images/icons/single.png", :reload => true, :colored_icon => true }
          ]
        })
          
    @@toolbar = nil
    # { :buttons =>     [
    #       { :label => "Single", :action => '/app/Single', 
    #         :icon => "/public/images/icons/single.png", :reload => true }, 
    #       { :label => "New Course",  :action => '/app/NewCourse',  
    #         :icon => "/public/images/icons/single.png", :reload => true },
    #       { :label => "History",  :action => '/app/History',  
    #         :icon => "/public/images/icons/single.png", :reload => true },
    #       { :label => "Scorecard",   :action => '/app/Scorecard', 
    #         :icon => "/public/images/icons/single.png", :reload => true },
    #       { :label => "Settings",   :action => '/app/Settings', 
    #         :icon => "/public/images/icons/single.png", :reload => true }
    #     ], :background_color => 0x0000FF, :mask_color => 0xFFFFFF, :view_height => 200 }
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    #SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
  end
end
