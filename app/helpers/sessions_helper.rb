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
  
  def deny_access
    redirect_to login_path, notice: "You must be logged in to access that page"
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
