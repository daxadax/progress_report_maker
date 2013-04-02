class SessionsController < ApplicationController
  
  def new
    @title = "Log in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      @title = "Log in"
      flash.now[:login_error] = "Invalid email/password combination.  Have you #{ActionController::Base.helpers.link_to "forgotten your password?", '#'}".html_safe
      render 'new'
    else  
      #handle successful login  
    end
      
  end
  
  def destroy
  end
  
  
end