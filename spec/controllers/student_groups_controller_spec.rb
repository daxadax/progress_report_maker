require 'spec_helper'

describe StudentGroupsController do
render_views

  before(:each) do
    @user = test_login(Factory(:user))
    @sg1 = Factory(:student_group, user: @user)
    @sg2 = Factory(:student_group, user: @user, name: "class 2")
    @student_groups = [@sg1, @sg2]
  end

  describe "GET 'index" do
  
    before(:each) do
      @index = get :index, id: @user, user_id: @user.id
    end
        
    it "should be successful" do
       @index
       response.should be_success
     end
   
    it "should have the right title" do
       @index
       response.should have_selector('title', content: "All classes")
     end
   
    it "should have an element for each class" do
       @index
       @student_groups.each do |student_group|
         response.should have_selector('th', content: student_group.name)
       end
     end
     
  end
  
  describe "GET 'show'" do
    
      before(:each) do
        @show = get :show, id: @sg1.id, user_id: @user.id
      end
      
      it "should be successful" do
        @show
        response.should be_success
      end
    
      it "should have the right title" do
        @show
        response.should have_selector("title", content: @sg1.name)
      end
  end
  
  describe "GET 'new'" do
  
    before(:each) do
      @new = get :new, user_id: @user
    end  
  
    it "should be successful" do
      @new
      response.should be_success
    end

    it "should have the right title" do
      @new
      response.should have_selector('title', :content => "Create a new class" )
    end 
    
  end
   
end