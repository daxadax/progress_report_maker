module SessionsHelper
  
  # log in
  
  def login(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt] # or? = user.remember_token
    current_user = user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # log out
  
  def logout
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  # Current User
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  #####################################
  #Deny Access and Friendly Forwarding#
  #####################################
   
  def deny_access
    store_location
    redirect_to login_path, notice: "You must be logged in to access that page"
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default) 
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  # PRIVATE METHODS
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end  
    
end
