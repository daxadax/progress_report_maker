require 'spec_helper'

describe "LayoutLinks" do

  describe "static pages" do
    
    it "should have a home page at '/'" do
      get '/'
      response.should have_selector('title', content: " | Log In or Sign up" )  
    end

    it "should have an about page at '/about'" do
      get '/about'
      response.should have_selector('title', content: "About" )  
    end

    it "should have a contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', content: "Contact" )  
    end

    it "should have an error page at '/error" do
      get '/error'
      response.should have_selector('title', content: "Error")
    end

    it "should have a help page at '/help'" do
      get '/help'
      response.should have_selector('title', content: "Help" )  
    end

    it "should have a signup page at '/signup'" do
       get '/signup'
       response.should have_selector('title', content: "Sign up" )  
    end

    it "should have a login page at '/login'" do
        get '/login'
        response.should have_selector('title', content: "Log In" )  
    end
    
  end
  
  describe "when user is NOT logged in" do
    
    it "should have a 'log in' link" do
      visit about_path
      response.should have_selector("a", href: login_path,
                                         content: "Log In")
    end
    
    it "should root to the landing page" do
      visit root_path
      response.should have_selector('title', content: "Log In or Sign up")
    end
    
  end
  
  describe "when user is logged in" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit login_path
      fill_in 'session_email',    with: @user.email
      fill_in 'session_password', with: @user.password
      click_button
    end
    
    it "should have a 'log out' link" do
      visit about_path
      response.should have_selector("a", href: logout_path,
                                         content: "Log out")
    end
    
    it "should root to the groups#index page" do
      visit root_path
      response.should have_selector('title', content: "All groups")
    end

    it "should confirm before deleting a user" do
      visit edit_user_path(@user)
      click_link "Delete your account"
      response.should have_selector('title', content: "Are you sure?") 
    end
    
    it "should have a 'settings' link on each page" do
      visit groups_path
      response.should have_selector("a", href: settings_path)
    end
    
    describe "settings page" do

      let(:sg) { FactoryGirl.create(:student_group, user: @user) }

      it "should have a settings page at /settings" do
        get '/settings'
        response.should have_selector('title', content: "Settings")
      end
      
      it "should link to user settings" do
        get '/settings'
        response.should have_selector("a", href: edit_user_path(@user))
      end
      
      it "should link to student group settings if there are student groups" do
        get '/settings'
        response.should_not have_selector("a", href: edit_student_group_path(sg))
      end
      
      it "should have an element for each student group" do
        get '/settings'
        @user.student_groups.all.each do |group|
          puts group
          response.should have_selector('a', content: "#{group.name}" )
        end
      end
      
    end    
    
    describe "custom/model specific routes" do
      
      before(:each) do
        @sg = FactoryGirl.create(:student_group, user: @user)
      end
         
      it "should have a student_groups#index page at /groups" do
        get '/groups'
        response.should have_selector('title', content: "All groups")
      end

      it "should have a student_groups#show page at /group/:id" do
        get "group/#{@sg.id}"
        response.should have_selector('title', content: "#{@sg.name}")
      end
      
    end
    
    describe "redirects" do
      
      before(:each) do
        @user = FactoryGirl.create(:user)
        @student_group = FactoryGirl.create(:student_group, user: @user)
        @student = FactoryGirl.create(:student, student_group: @student_group)
      end
      
    # After creation of Student Group
      it "should redirect to group_path" # do
      #         visit new_student_group_path
      #         fill_in 'student_group_name', with: @student_group.name
      #         fill_in 'student_group_type_of_group', with:@student_group.type_of_group
      #         click_button
      #         response.should have_selector('title', content: "#{@student_group.name}")
      #       end
      
    # After creation of Student
      it "should redirect to student_group#show" # do
      #         visit new_student_group_student_path(@student, {student_group_id: @student_group.id})
      #         fill_in 'student_name', with: @student.name
      #         fill_in 'student_gender', with: @student.gender
      #         click_button
      #         response.should have_selector('title', content: "#{@student_group.name}")
      #       end
      
    end
    
  end
  
end
