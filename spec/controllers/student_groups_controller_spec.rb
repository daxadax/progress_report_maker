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
       response.should have_selector('title', content: "All groups")
     end
   
    it "should have an element for each class" do
       @index
       @student_groups.each do |student_group|
         response.should have_selector('h1', content: student_group.name)
       end
     end
     
  end
  
  describe "GET 'show'" do
    
      before(:each) do
        @show = get :show, id: @sg1.id
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
      @new = get :new
    end  
  
    it "should be successful" do
      @new
      response.should be_success
    end

    it "should have the right title" do
      @new
      response.should have_selector('title', :content => "Create a new group" )
    end 
    
  end
  
  describe "POST 'create'" do

    describe "failure" do
        
      before(:each) do
        @attr = {name: "", type_of_group: ""}
        @student_attr = [{name: "dax", gender: "Male"}, {name: "sally twotrees", gender: "Female"}]
        @create = post :create, student_group: @attr, student: @student_attr
      end
      
      it "should have the right title" do
        @create
        response.should have_selector('title', :content => "Create a new group" )
      end
      
      it "should render the 'new' page" do
        @create
        response.should render_template('new')
      end
      
      it "should not create a user" do
        lambda do
          post :create, student_group: @attr
        end.should_not change {@user.student_groups.count}
      end
      
      it "should flash an error message" do
        @create
        flash[:error].should =~ /please/i
      end
      
    end
      
    describe "success" do
      
      before(:each) do
        @attr = FactoryGirl.attributes_for(:student_group)
        # @student_attr = {name: "test", gender: "Male"}
      end     
     
      it "should create a student_group" do  
        lambda do
          post :create, student_group: @attr
        end.should change {@user.student_groups.count}.by(1)
      end
      
      it "should create students" # do
      #         lambda do
      #           post :create, student_group: @attr, student: @student_attr
      #         end.should change {@student_groups.students.count}.by(1)  
      #       end  
      
      it "should flash a success message" do
        post :create, student_group: @attr
        flash[:success].should =~ /has been added/i
      end
      
      it "should redirect" do
        post :create, student_group_id: @group, student_group: @attr
        response.should be_redirect
      end
                                   
    end 
  
  end

  describe "GET 'edit" do
    
    before(:each) do
      @edit = get :edit, id: @sg1.id, user_id: @user.id
    end

     it "should be successful" do
       @edit
       response.should be_success
     end

     it "should have the right title" do
       @edit
       response.should have_selector('title', content: "Edit group")
     end
    
  end

  describe "PUT 'update" do
    
    describe "failure" do
      
      before(:each) do
        @attr = {name: "", type_of_group: ""}
        @update = put :update, {user_id: @user.id, id: @sg1.id, student_group: @attr}
      end
      
      it "should render the 'edit' page" do
        @update
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        @update
        response.should have_selector('title', content: "Edit group")
      end
      
      it "should flash an error message" do
        @update
        flash[:error].should =~ /please/i
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {name: "Example Class", type_of_group: "Primary class (7-12)"}
        @update = put :update, {user_id: @user.id, id: @sg1.id, student_group: @attr}
      end
      
      it "should change the user's attributes" do
        @update
        student_group = assigns(:student_group)
        @user.reload
        @user.student_groups.name.should == @user.student_groups.name
      end
      
      it "should redirect to student_groups#index" do
        @update
        response.should redirect_to classes_path
      end
      
      it "should flash 'Update successful'" do
        @update
        flash[:success].should =~ /update/i
      end
      
    end
    
  end

  describe "DELETE 'destroy'" do
      
    it "should destroy the group" do
      lambda do
        delete :destroy, id: @sg1.id, user_id: @user.id
      end.should change {@user.student_groups.count}.by(-1)
    end
    
    it "flash a success message" do
      delete :destroy, id: @sg1.id, user_id: @user.id
      flash[:success].should =~ /deleted/i
    end
    
    it "should redirect to student_groups#index" do
      delete :destroy, id: @sg1.id, user_id: @user.id
      response.should redirect_to classes_path
    end
  
  end
    
end 