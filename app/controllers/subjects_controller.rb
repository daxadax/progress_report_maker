class SubjectsController < ApplicationController
  include IndexHelper
  
  before_filter :get_student_group, except: [:index]
  before_filter :get_subject, except: [:index, :new, :create]    
  
  def index
    index_helper
    @title = "All subjects"
  end  
  
   def show
     @title = "#{@subject.name}"
   end
   
  def new    
    @subject = @student_group.subjects.build
    @title = "Add a subject"
  end
  
  def create
    @subject = @student_group.subjects.create(params[:subject])
      if @subject.save
        redirect_to class_path(@student_group, {id: @student_group.id}), flash: { success: "Subject added successfully" }
      else
        @title = "Add a subject"
        flash.now[:error] = "Something's gone wrong.  Please try again!"
        render 'new' 
      end    
  end
  
  def edit
    @title = "Edit subject"
  end
  
  def update
    if @subject.update_attributes(params[:subject])
      redirect_to class_path(@student_group, {id: @student_group.id}), flash: { success: "#{@subject.name} updated successfully" }
    else  
      @title = "Edit subject"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end
  
  def destroy
    @subject.destroy
    redirect_to class_path(@student_group), flash: { success: "#{@subject.name} has been deleted" }
  end
  
  def stub
  end
  
  # #methods
  
  def get_student_group
    @user = current_user
    @student_group = @user.student_groups.find(params[:student_group_id])
  end
  # 
  def get_subject
    @subject = @student_group.subjects.find(params[:id])
  end
  
  
end
