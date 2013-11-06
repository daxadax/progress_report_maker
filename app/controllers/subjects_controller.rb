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
    @goals = @subject.goals.build
    @title = "Add a subject"
  end
  
  def create
    @subject = @student_group.subjects.create(params[:subject])
    @goals = params[:goals]
    if @subject.save
      create_goals if @goals.present?
      if @goal.save
        another_subject
      else
        @title = "Add a subject"
        flash.now[:error] = "Please add at least one goal for #{@subject.name}!" 
        render 'new'
      end
    else
      @title = "Add a subject"
      view_context.flash_failure
      render 'new' 
    end    
  end
  
  def edit
    @goals = @subject.goals
    @title = "Edit subject"
  end
  
  def update
    @goals = params[:goals]
    if @subject.update_attributes(params[:subject])
      create_goals if @goals.present?
      redirect_to root_path, flash: { success: "#{@subject.name} updated successfully" }
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
  
  private 
  
  def get_subject
    @subject = @student_group.subjects.find(params[:id])
  end
  
  def create_goals
    @goals.each do |goal|
      @goal = @subject.goals.create(goal: goal)
    end  
  end
  
  def another_subject
    if params[:another_subject]
      redirect_to new_student_group_subject_path(@subject.student_group_id),
                  flash: { success: "#{@subject.name} created successfully" }
    else
      redirect_to groups_path, 
                  flash: { success: "#{@student_group.name} created successfully!" }
    end
  end
  
  
end
