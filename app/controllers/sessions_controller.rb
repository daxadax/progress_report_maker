class SessionsController < ApplicationController
  
  def new
    @title = "Log In"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      @title = "Log In"
      flash.now[:login_error] = "Invalid email/password combination.  
      Have you #{ActionController::Base.helpers.link_to "forgotten your password?", 
               new_password_reset_path}".html_safe
      render 'new'
    else  
      login user
      redirect_back_or root_path
    end
      
  end
  
  def destroy
    logout
    redirect_to login_path
  end

end