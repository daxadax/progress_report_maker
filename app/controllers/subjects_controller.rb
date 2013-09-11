class SubjectsController < ApplicationController
  include IndexHelper
  
  before_filter :get_student_group, except: [:index] #in ApplicationController
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
        redirect_to new_subject_goal_path(@subject),
        flash: { success: "Subject added successfully, now create some goals" }
      else
        @title = "Add a subject"
        view_context.flash_failure
        render 'new' 
      end    
  end
  
  def edit
    @title = "Edit subject"
  end
  
  def update
    if @subject.update_attributes(params[:subject])
      redirect_to groups_path(@student_group), flash: { success: "#{@subject.name} updated successfully" }
    else  
      @title = "Edit subject"
      view_context.flash_failure
      render 'edit'
    end  
  end
  
  def destroy
    @subject.destroy
    redirect_to group_path(@student_group), flash: { success: "#{@subject.name} has been deleted" }
  end
  
  def stub
  end
  
  # #methods
  
  def get_subject
    @subject = @student_group.subjects.find(params[:id])
  end
  
  
end
