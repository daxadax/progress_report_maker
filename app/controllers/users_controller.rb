class UsersController < ApplicationController
  
  def show
    # if logged_in?
      @user = User.find(params[:id])
    # else 
    #   redirect_to login_path
    # end
    
    @title = @user.name
  end
  
  def new
    @user  = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      login @user
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end  
  end
  
  def edit
    # if logged_in?
      @user = User.find(params[:id])
    # else
    #       redirect_to login_path
    #     end

    @title = "User settings"
  end
    
  def update
    @user  = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, flash: { success: "Update successful"}
    else  
      @title = "User settings"
      render 'edit'
    end  
  end
  
end