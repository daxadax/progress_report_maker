class UsersController < ApplicationController
  
  before_filter :authenticate, only: [:show, :edit, :update]
  before_filter :correct_user, only: [:show, :edit, :update]
  
  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
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
  
  private
  
    def authenticate
      deny_access unless logged_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end  
    
end