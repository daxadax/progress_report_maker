require 'spec_helper'

describe "LayoutLinks" do

  it "should have a home page at '/'" do
    get '/'
    response.should have_selector('title', :content => " | Login or Sign up", )  
  end

  it "should have an about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About", )  
  end

  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact", )  
  end

  it "should have a help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help", )  
  end

  it "should have a signup page at '/signup'" do
     get '/signup'
     response.should have_selector('title', :content => "Sign up", )  
  end
  
  it "should have a login page at '/login'" do
      get '/login'
      response.should have_selector('title', :content => "Log in", )  
  end

  # it "should have a signout page at '/signout'" do
  #     get '/signout'
  #     response.should have_selector('title', :content => "Sign out", )  
  # end
  
end
