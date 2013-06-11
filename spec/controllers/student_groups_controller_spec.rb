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
      @new = get :new, user_id: @user.id
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
  
  describe "POST 'create'" do

    describe "failure" do
        
      before(:each) do
        @attr = {name: ""}
        @create = post :create, {user_id: @user.id, student_group: @attr}
      end
      
      it "should have the right title" do
        @create
        response.should have_selector('title', :content => "Create a new class" )
      end
      
      it "should render the 'new' page" do
        @create
        response.should render_template('new')
      end
      
      it "should not create a user" do
        lambda do
          @create = post :create, {user_id: @user.id, student_group: @attr}
        end.should_not change {@user.student_groups.count}
      end
      
      it "should flash an error message" do
        @create
        flash[:error].should =~ /please/i
      end
      
    end
      
    describe "success" do
                                   
      before(:each) do
        @attr = {name: "Example Class"}
        @create = post :create, {user_id: @user.id, student_group: @attr}
      end
     
      it "should create a user" do  
        lambda do
          post :create, {user_id: @user.id, student_group: @attr}
        end.should change {@user.student_groups.count}.by(1)
      end
      
      it "should redirect to the student_group index (FOR NOW!)" do
        @create
        response.should redirect_to classes_path
      end
      
      it "should flash a success message" do
        @create
        flash[:success].should =~ /students/i
      end
                                   
    end 
  end
end 