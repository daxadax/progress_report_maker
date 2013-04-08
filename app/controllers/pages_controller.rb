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
    render :layout => 'layouts/landing'
  end
  
  def farewell
    @title = "Farewell!"
  end
  
end
