class PagesController < ApplicationController
  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
  
  def home
    user = current_user  
    
    if logged_in? 
      redirect_to user
    else
      render :layout => 'layouts/landing'
    end
  end
  
  def farewell
    @title = "Farewell!"
  end
  
end
