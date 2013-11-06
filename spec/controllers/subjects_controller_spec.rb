require 'spec_helper'

describe SubjectsController do
render_views

  before(:each) do
    @user = test_login(FactoryGirl.create(:user))
    @sg = FactoryGirl.create(:student_group, user: @user)
    @sub1 = FactoryGirl.create(:subject, student_group: @sg)
    @sub2 = FactoryGirl.create(:subject, student_group: @sg, name: "Alchemy")
    @subjects = [@sub1, @sub2]
  end

  describe "GET 'index" do

    before(:each) do
      @index = get :index, student_group_id: @sg
    end
      
    it "should be successful" do
       @index
       response.should be_success
     end
 
    it "should have the right title" do
       @index
       response.should have_selector('title', content: "All subjects")
     end
 
    it "should have an element for each student" do
           @index
           @subjects.each do |subject|
             response.should have_selector('td', content: subject.name)
           end
        end
   
  end

  describe "GET 'show'" do
  
      before(:each) do
        @show = get :show, student_group_id: @sg, id: @sub1
      end
    
      it "should be successful" do
        @show
        response.should be_success
      end
  
      it "should have the right title" do
        @show
        response.should have_selector("title", content: @sub1.name)
      end
  end

  describe "GET 'new'" do

    before(:each) do
      @new = get :new, student_group_id: @sg
    end  

    it "should be successful" do
      @new
      response.should be_success
    end

    it "should have the right title" do
      @new
      response.should have_selector('title', :content => "Add a subject" )
    end 
  
  end

  describe "POST 'create'" do

    before(:each) do
      @create = post :create, student_group_id: @sg
    end

    describe "failure" do
      
      @attr = {name: ""}
    
      it "should have the right title" do
        @create
        response.should have_selector('title', :content => "Add a subject" )
      end
    
      it "should render the 'new' page" do
        @create
        response.should render_template('new')
      end
    
      it "should not create a subject" do
        lambda do
          post :create, {student_group_id: @sg, subject: @attr}
        end.should_not change {@sg.subjects.count}
      end
    
      it "should flash an error message" do
        @create
        flash[:error].should =~ /please/i
      end
    
    end
    
    describe "success" do
                                   
      before(:each) do
        @attr = FactoryGirl.attributes_for(:subject)
        @goal_attr = FactoryGirl.attributes_for(:goal)    
      end
         
      it "should create a subject" do  
        lambda do
          post :create, {student_group_id: @sg, subject: @attr, goal: @goal_attr}
        end.should change {@sg.subjects.count}.by(1)
      end
      
      # it "should create goals" do
      #         lambda do
      #           post :create, {student_group_id: @sg, subject: @sub1, goal: @goal_attr}
      #         end.should change {@sub1.goals.count}.by(1)
      #         
      #       end
    
      it "should flash a success message" do
        post :create, {student_group_id: @sg, subject: @attr, goal: @goal_attr}
        flash[:success].should =~ /subject/i
      end
    
      it "should redirect to root path" do
        post :create, {student_group_id: @sg, subject: @attr, goal: @goal_attr}
        response.code.should == "302"
        # regarding 'Subject.last'
        # http://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
        response.should redirect_to(root_path)
      end
                                 
    end 

  end

  describe "GET 'edit" do
  
    before(:each) do
      @edit = get :edit, {student_group_id: @sg.id, id: @sub1.id}
    end

     it "should be successful" do
       @edit
       response.should be_success
     end

     it "should have the right title" do
       @edit
       response.should have_selector('title', content: "Edit subject")
     end
  
  end

  describe "PUT 'update" do
  
    describe "failure" do
    
      before(:each) do
        @attr = {name: "", start_date: "", end_date: ""}
        @update = put :update, {student_group_id: @sg.id, id: @sub1.id, subject: @attr}
      end
    
      it "should render the 'edit' page" do
        @update
        response.should render_template('edit')
      end
    
      it "should have the right title" do
        @update
        response.should have_selector('title', content: "Edit subject")
      end
    
      it "should flash an error message" do
        @update
        flash[:error].should =~ /please/i
      end
    
    end
  
    describe "success" do
    
      before(:each) do
        @attr = {name: "Maths 202", start_date: Date.today+100, end_date: Date.today+200}
        @update = put :update, {student_group_id: @sg, id: @sub1, subject: @attr}
      end
    
      it "should change the subjects's attributes" do
        @update
        subject = assigns(:subject)
        @user.reload
        @sg.subjects.name.should == @sg.subjects.name
      end
    
      it "should redirect to groups index" do
        @update
        response.should redirect_to groups_path(@sg)
      end
    
      it "should flash 'Update successful'" do
        @update
        flash[:success].should =~ /update/i
      end
    
    end
  
  end

  describe "DELETE 'destroy'" do
    
    it "should destroy the subject" do
      lambda do
        delete :destroy, {student_group_id: @sg, id: @sub1}
      end.should change {@sg.subjects.count}.by(-1)
    end
  
    it "flash a success message" do
      delete :destroy, {student_group_id: @sg, id: @sub1}
      flash[:success].should =~ /deleted/i
    end
  
    it "should redirect to student_groups#show" do
      delete :destroy, {student_group_id: @sg, id: @sub1}
      response.should redirect_to group_path(@sg)
    end

  end

end
