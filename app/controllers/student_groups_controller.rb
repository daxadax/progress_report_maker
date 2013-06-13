class StudentGroupsController < ApplicationController
  
  before_filter :get_user


  def index
    @student_groups = @user.student_groups
    @title = "All groups"
  end
  
  def new
    @student_group  = @user.student_groups.new
    @title = "Create a new group"
  end

  def show
    # this isn't finished!
    @student_group = @user.student_groups.find(params[:id])
    @title = "#{@student_group.name}"
  end
  
  def create
    @student_group = @user.student_groups.create(params[:student_group])
    if @student_group.save
      # for now redirect to 
      redirect_to classes_path, flash: { success: "#{@student_group.name} created! Next, add some students" }
      # redirect_to new_student_group_student_path
    else
      @title = "Create a new group"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'new' 
    end  
  end
  
  def edit
    @student_group = @user.student_groups.find(params[:id])
    @title = "Edit group"
  end

  def update
    @student_group = @user.student_groups.find(params[:id])
    if @user.student_groups.find(params[:id]).update_attributes(params[:student_group])
      redirect_to classes_path, flash: { success: "#{@student_group.name} updated successfully" }
    else  
      @title = "Edit group"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end

  def destroy
    @student_group = @user.student_groups.find(params[:id])
    @student_group.destroy
    flash.now[:success] = "#{@student_group.name} has been deleted"
    redirect_to classes_path
  end
  
    # methods
  def get_user
    @user = User.find(current_user)
  end 
  
end