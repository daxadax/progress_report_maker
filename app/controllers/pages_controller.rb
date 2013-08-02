class PagesController < ApplicationController
  
  def about
    @title = "About"
  end
 
  def confirmation
    @user = current_user
    @title = "Are you sure?"
  end

  def contact
    @title = "Contact"
  end

  def error
    @title = "Error"
  end

  def final_farewell
    @title = "Smell you later forever"
  end

  def help
    @title = "Help"
  end
  
  def home
    user = current_user  
    
    #this is for users_controller.rb:58
    flash.keep(:access)
    
    if logged_in? 
      redirect_to classes_path
    else
      render :layout => 'layouts/landing'
    end
  end
    
  def settings
    @user = current_user
    @title = "#{@user.name} > Edit"
  end
    
end
