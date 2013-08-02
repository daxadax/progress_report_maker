require 'spec_helper'

describe StudentsController do
render_views

before(:each) do
  @user = test_login(Factory(:user))
  @sg = Factory(:student_group, user: @user)
  @s1 = Factory(:student, student_group: @sg)
  @s2 = Factory(:student, student_group: @sg, name: "Bendegúz")
  @students = [@s1, @s2]
end

describe "GET 'index" do

  before(:each) do
    @index = get :index, student_group_id: @sg, id: @sg
  end
      
  it "should be successful" do
     @index
     response.should be_success
   end
 
  it "should have the right title" do
     @index
     response.should have_selector('title', content: "All students")
   end
 
  it "should have an element for each student" do
     @index
     @students.each do |student|
       response.should have_selector('td', content: student.name)
     end
  end
   
end

describe "GET 'show'" do
  
    before(:each) do
      @show = get :show, student_group_id: @sg, id: @s1
    end
    
    it "should be successful" do
      @show
      response.should be_success
    end
  
    it "should have the right title" do
      @show
      response.should have_selector("title", content: @s1.name)
    end
end

describe "GET 'new'" do

  before(:each) do
    @new = get :new, student_group_id: @sg, id: @sg
  end  

  it "should be successful" do
    @new
    response.should be_success
  end

  it "should have the right title" do
    @new
    response.should have_selector('title', :content => "Add a student" )
  end 
  
end

describe "POST 'create'" do

  before(:each) do
    @create = post :create, {student_group_id: @sg, id: @sg}
  end

  describe "failure" do
      
    @attr = {name: ""}
    
    it "should have the right title" do
      @create
      response.should have_selector('title', :content => "Add a student" )
    end
    
    it "should render the 'new' page" do
      @create
      response.should render_template('new')
    end
    
    it "should not create a student" do
      lambda do
        post :create, {student_group_id: @sg, id: @sg, student: @attr}
      end.should_not change {@sg.students.count}
    end
    
    it "should flash an error message" do
      @create
      flash[:error].should =~ /please/i
    end
    
  end
    
  describe "success" do
                                 
    before(:each) do
      @attr = {name: "John", gender: "Transgender"}
    end
   
    it "should create a student" do  
      lambda do
        post :create, {student_group_id: @sg, id: @sg, student: @attr}
      end.should change {@sg.students.count}.by(1)
    end
    
    it "should flash a success message" do
      post :create, {student_group_id: @sg, id: @sg, student: @attr}
      flash[:success].should =~ /student/i
    end
                                 
  end 

end

describe "GET 'edit" do
  
  before(:each) do
    @edit = get :edit, {student_group_id: @sg.id, id: @s1.id}
  end

   it "should be successful" do
     @edit
     response.should be_success
   end

   it "should have the right title" do
     @edit
     response.should have_selector('title', content: "Edit student")
   end
  
end

describe "PUT 'update" do
  
  describe "failure" do
    
    before(:each) do
      @attr = {name: "", gender: ""}
      @update = put :update, {student_group_id: @sg.id, id: @s1.id, student: @attr}
    end
    
    it "should render the 'edit' page" do
      @update
      response.should render_template('edit')
    end
    
    it "should have the right title" do
      @update
      response.should have_selector('title', content: "Edit student")
    end
    
    it "should flash an error message" do
      @update
      flash[:error].should =~ /please/i
    end
    
  end
  
  describe "success" do
    
    before(:each) do
      @attr = {name: "John", gender: "Transgender"}
      @update = put :update, {student_group_id: @sg, id: @s1, student: @attr}
    end
    
    it "should change the user's attributes" do
      @update
      student = assigns(:student)
      @user.reload
      @sg.students.name.should == @sg.students.name
    end
    
    it "should redirect to student_groups#show" do
      @update
      response.should redirect_to group_path
    end
    
    it "should flash 'Update successful'" do
      @update
      flash[:success].should =~ /update/i
    end
    
  end
  
end

describe "DELETE 'destroy'" do
    
  it "should destroy the student" do
    lambda do
      delete :destroy, {student_group_id: @sg, id: @s1}
    end.should change {@sg.students.count}.by(-1)
  end
  
  it "flash a success message" do
    delete :destroy, {student_group_id: @sg, id: @s1}
    flash[:success].should =~ /deleted/i
  end
  
  it "should redirect to student_groups#show" do
    delete :destroy, {student_group_id: @sg, id: @s1}
    response.should redirect_to group_path
  end

end


end