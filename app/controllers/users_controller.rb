class UsersController < ApplicationController
  
  before_filter :authenticate, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :admin?,       only: :index
  
  def index
    @users = User.all
    @title = "User index"
  end
  
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
      redirect_to first_time_path
    else
      @title = "Sign up"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'new'
    end  
  end
  
  def edit
    @title = "User settings"
  end
    
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, flash: { success: "Update successful" }
    else  
      @title = "User settings"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to finalfarewell_path
  end
  
  private
  
    def authenticate
      deny_access unless logged_in? 
    end
    
    def correct_user
      @user = User.find(params[:id])
      # redirect_to root_path unless @user == current_user 
      unless @user == current_user
        # EDIT THIS LATER TO INCLUDE LINK LOCATION! #see pages_controller.rb:18
        redirect_to root_path, flash: { access: "Something has gone wrong.  
          If you're trying to access a page, try the links on the top right" }
      end
    end  
    
    def admin?
      #http://stackoverflow.com/questions/15855138/undefined-method-admin-for-nilnilclass
      redirect_to error_path unless current_user.try(:admin?)
    end
end