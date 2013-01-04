require 'rho/rhocontroller'

class NewCourseController < Rho::RhoController
  # @@course = nil
  
  def index
    if $session[:course] != nil && !(@params != nil && @params["reset"] == "1")
      # WebView.navigate( url_for(:controller => :Hole, :action => :swing_input))
      @course = Course.find($session[:course])
      redirect :controller => :Hole, :action => :swing_input
    end
    render :action => :index, :back => '/app'  
  end

  def new_course
    params = @params["newcourse"]
    @course = Course.create(:club_name => params["club_name"], :course_name => params["course_name"], :holes_count => params["holes_count"].to_i, :gender => (params["gender"] == "1"), :player_level => (params["player_level"] == "1"))
    $session[:course] = @course.object
    redirect :controller => "Hole", :action => "new", :query => {:course => @course.object}
  end
  
  def delete_all
    Course.delete_all
    Hole.delete_all
    Swing.delete_all
  end
  
end