require 'spec_helper'

describe PagesController do
  render_views

 before(:each) do
   @base_title = "Ganesh"
end

  describe "GET 'about'" do
    
    it "should return http success" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", 
                                    content: "#{@base_title} | About")
    end

  end 

  describe "GET 'error'" do
    
    it "should return http success" do
      get 'error'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'error'
      response.should have_selector('title',
                                    content: "#{@base_title} | Error")
    end
    
  end
 
  describe "GET 'contact'" do
    
    it "should return http success" do
      get 'contact'
      response.should be_success
    end
  
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", 
                                    content: "#{@base_title} | Contact")
    end      
  
  end         

  describe "GET 'farewell" do
    
    it "should return http success" do
      get 'farewell'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'farewell'
      response.should have_selector('title',
                                    content: "#{@base_title} | Farewell!")
    end
    
  end

  describe "GET 'final_farewell" do
    
    it "should return http success" do
      get 'final_farewell'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'final_farewell'
      response.should have_selector('title',
                                    content: "#{@base_title} | Smell you later forever")
    end
    
  end

  describe "GET 'help'" do
    
    it "should return http success" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", 
                                    :content => "#{@base_title} | Help")
    end
  
  end

end