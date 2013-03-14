require 'spec_helper'

describe UsersController do
  render_views
    
  describe "GET 'show" do
    
    before(:each) do
      @user = Factory(:user)
      @show = get :show, :id => @user
    end
    
    it "should be sucessful" do
      @show
      response.should be_success
    end
    
    it "should find the right user" do
      @show
      assigns(:user).should == @user
    end
  
    it "should have the right title" do
      @show
      response.should have_selector('title', :content => @user.name )
    end 
    
    it "should have the user's name as h1" do
      @show
      response.should have_selector('h1', :content => @user.name )
    end
    
  end
  
  describe "GET 'new'" do
  
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign up" )
    end 
    
  end
  
end
