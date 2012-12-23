require 'rho/rhocontroller'

class NewCourseController < Rho::RhoController
  
  def index
    render :back => '/app'  
  end

  def new_course
    params = @params["newcourse"]
    @@course = Course.create(:club_name => params["club_name"], :course_name => params["course_name"], :holes_count => params["holes_count"].to_i, :gender => (params["gender"] == "1"), :player_level => (params["player_level"] == "1"))
    redirect :controller => "Hole", :action => "new", :query => {:course => @@course.object}
  end
  
  def delete_all
    Course.delete_all
    Hole.delete_all
    Swing.delete_all
    render :nothing => true
  end
  
end