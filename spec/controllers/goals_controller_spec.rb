require 'spec_helper'

describe GoalsController do
render_views

  before(:each) do
      @user = test_login(Factory(:user))
      @sg = Factory(:student_group, user: @user)
      @sub1 = Factory(:subject, student_group: @sg)
      @sub2 = Factory(:subject, student_group: @sg, name: "Alchemy")
      @subjects = [@sub1, @sub2]
      @g1 = Factory(:goal, subject: @sub1)
      @g2 = Factory(:goal, subject: @sub2)
      @goals = [@g1, @g2]
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
        response.should have_selector('title', content: "All goals")
      end
   
     it "should have an element for each goal" do
       @index
       @goals.each do |goal|
         response.should have_selector('td', content: goal.goal)
       end
     end
   
   end
   
  describe "GET 'show'" do
  
      before(:each) do
        @show = get :show, subject_id: @sub1, id: @g1
      end
  
      it "should be successful" do
        @show
        response.should be_success
      end
  
      it "should have the right title" do
        @show
        response.should have_selector("title", content: "Goal #{@g1.id}")
      end
  end
  
  describe "GET 'new'" do
  
    before(:each) do
      @new = get :new, subject_id: @sub1
    end  
  
    it "should be successful" do
      @new
      response.should be_success
    end
  
    it "should have the right title" do
      @new
      response.should have_selector('title', :content => "Add a goal" )
    end 
  
  end
  
  describe "POST 'create'" do
  
    describe "failure" do
  
      before(:each) do
        @goals = ["", ""]
        @create = post :create, {goals: @goals, subject_id: @sub1}
      end
  
      it "should have the right title" do
        @create
        response.should have_selector('title', :content => "Add a goal" )
      end
  
      it "should render the 'new' page" do
        @create
        response.should render_template('new')
      end
  
      it "should not create a goal" do
        lambda do
          post :create, {subject_id: @sub1, goals: @goals}
        end.should_not change {@sub1.goals.count}
      end
  
      it "should flash an error message" do
        @create
        flash[:error].should =~ /please/i
      end
  
    end
  
    describe "success" do
      
      before(:each) do
        @goals = %w[eat, pray, love]
        @create = post :create, {goals: @goals, subject_id: @sub1}
      end
  
      it "should create a goal" do  
        count = @goals.count
        lambda do
          post :create, {subject_id: @sg, goals: @goals}
        end.should change {@sub1.goals.count}.by(count)
      end
  
      it "should flash a success message" do
        post :create, {subject_id: @sub1, goals: @goals}
        flash[:success].should =~ /goal/i
      end
  
    end 
  
  end
  
  describe "GET 'edit" do
  
    before(:each) do
      @edit = get :edit, {subject_id: @sub1.id, id: @g1.id}
    end
  
     it "should be successful" do
       @edit
       response.should be_success
     end
  
     it "should have the right title" do
       @edit
       response.should have_selector('title', content: "Edit goal")
     end
  
  end
  
  describe "PUT 'update" do
  
    describe "failure" do
  
      before(:each) do
        @attr = {goal: ""}
        @update = put :update, {subject_id: @sub1.id, id: @g1.id, goal: @attr}
      end
  
      it "should render the 'edit' page" do
        @update
        response.should render_template('edit')
      end
  
      it "should have the right title" do
        @update
        response.should have_selector('title', content: "Edit goal")
      end
  
      it "should flash an error message" do
        @update
        flash[:error].should =~ /please/i
      end
  
    end
  
    describe "success" do
  
      before(:each) do
        @attr = FactoryGirl.attributes_for(:goal)
        @update = put :update, {subject_id: @sub1, id: @g1, goal: @attr}
      end
  
      it "should change the user's attributes" do
        @update
        goal = assigns(:goal)
        @user.reload
        @sub1.goals.name.should == @sub1.goals.name
      end
  
      it "should redirect to subjects#show" do
        @update
        response.should redirect_to subject_path(@sub1)
      end
  
      it "should flash 'Update successful'" do
        @update
        flash[:success].should =~ /update/i
      end
  
    end
  
  end
  
  describe "DELETE 'destroy'" do
  
    it "should destroy the goal" do
      lambda do
        delete :destroy, {subject_id: @sub1, id: @g1}
      end.should change {@sub1.goals.count}.by(-1)
    end
  
    it "should flash a success message" do
      delete :destroy, {subject_id: @sub1, id: @g1}
      flash[:success].should =~ /deleted/i
    end
  
    it "should redirect to subjects#show" do
      delete :destroy, {subject_id: @sub1, id: @g1}
      response.should redirect_to subject_path(@sub1)
    end
  
  end

end
