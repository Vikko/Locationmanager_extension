class Course
  include Rhom::FixedSchema
  
  property :club_name, :string
  property :course_name, :string
  property :holes_count, :integer
  property :gender, :boolean #true = male
  property :player_level, :boolean #true = regular
end