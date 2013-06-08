require 'spec_helper'

describe StudentGroupsController do
render_views

  describe "GET 'index" do
  
     before(:each) do
       @user = test_login(Factory(:user))
       sg1 = Factory(:student_group, user: @user)
       sg2 = Factory(:student_group, user: @user, name: "class 2")
       @student_groups = [sg1, sg2]
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
         response.should have_selector('li', content: student_group.name)
       end
     end
     
  end
   
end