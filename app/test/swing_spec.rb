describe "Swing" do

  it "should create a model" do
      @swing = Swing.create() #, 'distance' => @params["distance"].to_f, 'heading' => @params["heading"].to_f})
      @swing.valid?.should == true
  end
end