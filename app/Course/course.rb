class Course
  include Rhom::FixedSchema
  
  property :club_name, :string
  property :course_name, :string
  property :holes_count, :integer
  property :temp, :boolean
  property :gender, :boolean #true = male
  property :player_level, :boolean #true = regular
  
  def get_holes
    Hole.find(:all, :conditions => ["course_id = ?", self.object])
  end
end