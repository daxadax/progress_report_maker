require 'spec_helper'

describe "LayoutLinks" do

  it "should have a home page at '/'" do
    get '/'
    response.should have_selector('title', content: " | Log in or Sign up", )  
  end

  it "should have an about page at '/about'" do
    get '/about'
    response.should have_selector('title', content: "About", )  
  end

  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', content: "Contact", )  
  end

  it "should have a help page at '/help'" do
    get '/help'
    response.should have_selector('title', content: "Help", )  
  end

  it "should have a signup page at '/signup'" do
     get '/signup'
     response.should have_selector('title', content: "Sign up", )  
  end
  
  it "should have a login page at '/login'" do
      get '/login'
      response.should have_selector('title', content: "Log in", )  
  end

  it "should have a post-logout page at '/farewell'" do
          get '/farewell'
          response.should have_selector('title', content: "Farewell!")  
  end
  
  describe "when user is not logged in" do
    
    it "should have a 'log in' link" do
      visit about_path
      response.should have_selector("a", href: login_path,
                                         content: "Log in")
    end
    
    it "should root to the home page" do
      visit root_path
      response.should have_selector('title', content: "Log in or Sign up")
    end
    
  end
  
  describe "when user is logged in" do
    
    before(:each) do
      @user = Factory(:user)
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
    
    it "should have a 'home' link" do
      visit about_path
      response.should have_selector("a", href: user_path(@user),
                                         content: "Home")
    end
    
    it "should root to the user show page" do
      visit root_path
      response.should have_selector('title', content: "#{@user.name}")
    end
    
    it "should have an edit link on the user#show page" do
      visit user_path
      response.should have_selector("a", href: edit_user_path(@user),
                                         content: "edit")
    end
    
    it "should have an 'edit user' page at /settings" # do
    #       get '/settings'
    #       response.should have_selector('title', content: "User settings")
    #     end
    
  end
  
end
