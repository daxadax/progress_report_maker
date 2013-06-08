class StudentGroupsController < ApplicationController
  
  before_filter :get_user


  def index
    @student_groups = @user.student_groups
    @title = "All classes"
  end
  
  # def new

  # end

  def show
    # this isn't finished!
    @title = :group_by_id.name
  end
  
  # def create
  #   if group_by_id.save
  # 
  #     where should this go?
  #     redirect_to @???
  #   else
  #     @title = "Sign up"
  #     render 'new'
  #   end  
  # end
  
  # def edit
  #   @title = "Edit Class"
  # end

  # def update
  #   if @user.update_attributes(params[:user])
  #     redirect_to @user, flash: { success: "Update successful" }
  #   else  
  #     @title = "User settings"
  #     render 'edit'
  #   end  
  # end

  # def destroy
  #   User.find(params[:id]).destroy
  #   redirect_to finalfarewell_path
  # end
  
    # methods
  def get_user
    @user = User.find(current_user)
  end
  
  def group_by_id
    @user.student_group(params[:id])
  end  
  
end