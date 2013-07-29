class GoalsController < ApplicationController
  include IndexHelper

  before_filter :get_subject, except: [:index]
  before_filter :get_goal, except: [:index, :new, :create]   
  
  def index
    index_helper
    @title = "All goals"      
  end  
  
   def show
     @title = "Goal #{@goal.id}"
   end
   
  def new    
    @goal = @subject.goals.build
    @title = "Add a goal"
  end
  
  def create
    @goal = @subject.goals.create(params[:goal])
      if @goal.save
        redirect_to subject_path(@subject, {student_group_id: @subject.student_group_id}), flash: { success: "Goal added successfully" }
      else
        @title = "Add a goal"
        flash.now[:error] = "Something's gone wrong.  Please try again!"
        render 'new' 
      end    
  end
  
  def edit
    @title = "Edit goal"
  end
  
  def update
    if @goal.update_attributes(params[:goal])
      redirect_to subject_path(@subject, {student_group_id: @subject.student_group_id}), flash: { success: "Goal #{@goal.id} updated successfully" }
    else  
      @title = "Edit goal"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end
  
  def destroy
    @goal.destroy
    redirect_to subject_path(@subject), flash: { success: "#{@goal.id} has been deleted" }
  end
  
  # #methods
  
  def get_subject
    @subject = Subject.find(params[:subject_id])
  end
  
  def get_goal
    @goal = @subject.goals.find_by_id(params[:id])
  end

end
