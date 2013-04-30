require 'spec_helper'

describe UsersController do
  render_views
    
  describe "GET 'index" do
    
    describe "for users" do
      
      it "should deny access" # do
      #         get :index
      #         response.should redirect_to error_path
      # end
      
    end
    
    describe "for superusers" do
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector('title', content: "User index")
      end
      
      it "should have an element for each user" do
        get :index
        User.all.each do |user|
          response.should have_selector('li', content: "user.name")
        end
      end
      
    end
    
  end
  
  describe "GET 'show" do
        
        before(:each) do
          @user = Factory(:user)
          test_login(@user)
          @show = get :show, :id => @user
        end
        
        it "should find the right user" do
          @show
          assigns(:user).should == @user
        end
      
        it "should have the right title" do
          @show
          response.should have_selector('title', content: @user.name )
        end 
        
        it "should have the user's name as h2" do
          @show
          response.should have_selector('h2', content: @user.name )
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
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = {name: "", email: "", password: "", password_confirmation: ""}
      end
      
      it "should have the right title" do
        post :create, user: @attr
        response.should have_selector('title', :content => "Sign up", )
      end
      
      it "should render the 'new' page" do
        post :create, user: @attr
        response.should render_template('new')
      end
      
      it "should not create a user" do
        lambda do
          post :create, user: @attr
        end.should_not change(User, :count)
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {
          name:                  "user", 
          email:                 "user@example.com", 
          password:              "password",
          password_confirmation: "password"
        }
      end
      
      it "should create a user" do
        lambda do
          post :create, user: @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user:show page" do
        post :create, user: @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should sign the user in" do
        post :create, user: @attr
        controller.should be_logged_in
      end
      
    end
    
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
      test_login(@user)
    end
    
    it "should be successful" do
      get :edit, id: @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, id: @user
      response.should have_selector('title', content: "User settings")
    end
    
  end

  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_login(@user)
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = {name: "", email: "", password: "", password_confirmation: ""}
      end
      
      it "should render the 'edit' page" do
        put :update, id: @user, user: @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, id: @user, user: @attr
        response.should have_selector('title', content: "User settings")
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { name: "New Name", 
                  email: "new_example@email.com", 
                  password: "pass-pass", 
                  password_confirmation: "pass-pass" 
                 }
      end
      
      it "should change the user's attributes" do
        put :update, id: @user, user: @attr
        user = assigns(:user)
        @user.reload
        @user.name.should        == user.name
        @user.email.should       == user.email
        @user.encrypted_password == user.encrypted_password
      end
      
      it "should flash 'Update successful'" do
        put :update, id: @user, user: @attr
        flash[:success].should =~ /update/i
      end
      
    end
    
  end

  describe "authentication of show/edit/update actions" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "for users that are not logged in" do
      
      it "should deny access to 'show'" do
        get :show, id: @user
        response.should redirect_to login_path
        flash[:notice].should =~ /must/
      end

      it "should deny access to 'edit'" do
        get :edit, id: @user
        response.should redirect_to login_path
      end

      it "should deny access to 'update'" do
        put :update, id: @user
        response.should redirect_to login_path
      end
        
    end
    
    describe "for users that are logged in" do
      
      before(:each) do
        wrong_user = Factory(:user, email: "wrong_user@example.com")
        test_login(wrong_user)
      end
      
      it "should only show the user their own profile" do
        get :show, id: @user
        response.should redirect_to root_path
        flash[:access].should =~ /access a page/
      end
      
      it "should require the correct user if editting" do
        get :edit, id: @user
        response.should redirect_to root_path
      end
      
      it "should require the correct user if updating" do
        put :update, id: @user
        response.should redirect_to root_path
      end
      
    end
    
  end

end
