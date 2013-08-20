require 'spec_helper'

describe EvaluationsController do
render_views

  before(:each) do
    association_attr
  end

  describe "'note'" do
    
    before(:each) do
      # http://stackoverflow.com/a/18272683/2128691
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
      @note = get :note, student_group_id: @student_group, student_id: @student
    end
    
    it "should be successful" do
      @note
      response.should be_success
    end
  
    it "should have the right title" do
      @note
      response.should have_selector('title', :content => "Before you begin" )
    end
    
    it "should have a 'help' link" do
      @note
      response.should have_selector("a",
                                    :href => eval_help_path,
                                    :content => "click here")
    end
    
    it "should have a 'confirm' link" do
      @note
      response.should have_selector("a",
                                    :href => evaluate_path(student_group_id: @student_group.id, student_id: @student_group.students.first.id),
                                    :content => "Begin evaluation")
    end
    
    it "should have a 'cancel' link" do
      @note
      response.should have_selector("a",
                                    :href => root_path,
                                    :content => "Cancel")
    end
    
  end

  describe "'help'" do
    
    before(:each) do
      @help = get :help
    end
    
    it "should be successful" do
      @help
      response.should be_success
    end
    
    it "should have the right title" do
      @help
      response.should have_selector('title', :content => "How to evaluate")
    end
    
    it "should be useful" # do
     #      
     #    end
    
  end

  describe "GET 'new'" do
    
    before(:each) do
       # http://stackoverflow.com/a/18272683/2128691
       ApplicationController.any_instance.stub(:current_user).and_return(@user)
       @new = get :new, student_group_id: @student_group, student_id: @student
    end  
  
      it "should be successful" do
        @new
        response.should be_success
      end
    
      it "should have the right title" do
        @new
        response.should have_selector('title', :content => "Evaluating" )
      end
    
      it "should list the goals by subject for the given student group" do
        @new
        response.should have_selector('td', content: @goal.goal)
      end
    
  end
  
  describe "POST 'create'" do
  
    before(:each) do
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
      @create = post :create, student_group_id: @student_group, student_id: @student
    end
  
    describe "failure" do
  
      it "should have the right title" do
        @create
        response.should have_selector('title', :content => "Evaluating" )
      end
  
      it "should render the 'new' page" do
        @create
        response.should render_template('new')
      end
  
      it "should not create a goal" do
        @attr = {score: ""}
        lambda do
          post :create, {student_group_id: @student_group, student_id: @student, evaluation: @attr}
        end.should_not change {@student.evaluations.count}
      end
  
      it "should flash an error message" do
        @create
        flash[:error].should =~ /wrong/i
      end
  
    end
  
    describe "success" do
  
      before(:each) do
        @attr = {student_group_id: @student_group, student_id: @student, evaluation: FactoryGirl.attributes_for(:evaluation)}
      end
  
      it "should render the 'new' action" do
        post :create, @attr
        response.should render_template('new')
      end
      
      # this works, but...
      # what the fuck is this mess?
      it "should create an evaluation for each goal" do  
        # how many goals are being evaluated?
        @i = @goals.count
        @evals = []
        lambda do
          # loop through all goals to be evaluated
          @goals.each do |goal|
            # for each goal, create evaluation data and push it into the '@evals' array
            @evals << @student.evaluations.create(score: "3", student_id: @student, goal_id: goal.id)
          end
          post :create, {student_group_id: @student_group, student_id: @student, evaluation: @evals}
        end.should change {@student.evaluations.count}.by(@i)
      end
  
      it "should warn that scores cannot be edited once submitted" do
        post :create, @attr
        response.should have_selector('p') do |p| 
          p.should contain(/please take a moment/)
        end             
      end
            
      it "should load the next student" # do
      #         post :create, @attr
      #         response.should render_template :new
      #         controller.params[:student_number].should eql @student_number    
      #       end
      
      it "should not allow users to stop once they've started (it stings)" do
        post :create, @attr
        response.should render_template("layouts/evaluation")     
      end 
      
      it "should not stop if there are still students left" do
        post :create, @attr, student_count: @student_group.students.count - 1
        response.should render_template(:new)
      end      
    
      describe "after evaluation complete" do
        
        it "should stop the evaluation when all students are evaluated" # do  
        #           
        #         end
        
        it "should flash a success message" # do
        #           post :create, @attr, student_number: @student_group.students.count
        #           flash[:success].should =~ /congratulations/i
        #         end
        
      end
      
    end  
  
  end

end
