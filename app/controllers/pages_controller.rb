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
    @title = "Home"
  end

end
