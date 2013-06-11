class StudentGroupsController < ApplicationController
  
  before_filter :get_user


  def index
    @student_groups = @user.student_groups
    @title = "All classes"
  end
  
  def new
    @student_group  = @user.student_groups.new
    @title = "Create a new class"
  end

  def show
    # this isn't finished!
    @student_group = @user.student_groups.find(params[:id])
    @title = "#{@student_group.name}"
  end
  
  def create
    @student_group = @user.student_groups.create(params[:student_group])
    if @student_group.save
      # flash ":name created! Next, add your students" 
      # for now redirect to 
      redirect_to classes_path, flash: { success: "#{@student_group.name} created! Next, add some students" }
      # redirect_to new_student_group_student_path
    else
      @title = "Create a new class"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'new' 
    end  
  end
  
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
  
end