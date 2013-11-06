class GoalsController < ApplicationController
  include IndexHelper
  include ApplicationHelper

  before_filter :get_subject, except: [:index]
  before_filter :get_goal, except: [:index, :new, :create]   
  
  def index
    index_helper
    @title = "All goals"
  end  
  
   def show
     index_helper
   end
   
  # def new    
  #   @goal = @subject.goals.build
  #   @title = "Add a goal"
  # end
  # 
  # def create
  #   @goals = params[:goals]
  #   @goals.each do |goal|
  #     @goal = @subject.goals.create(goal: goal)
  #   end
  #     if @goal.save
  #       if params[:another_subject]
  #         redirect_to new_student_group_subject_path(@subject.student_group_id),
  #                     flash: { success: "Goal(s) added successfully!" }
  #       else
  #         redirect_to groups_path, flash: { success: "Goal(s) added successfully!" }
  #       end
  #     else
  #       @title = "Add a goal"
  #       render 'new' 
  #     end    
  # end
  
  def edit
    @title = "Edit goal"
  end
  
  def update
    if @goal.update_attributes(params[:goal])
      redirect_to subject_path(@subject, {student_group_id: @subject.student_group_id}), 
                  flash: { success: "Goal updated successfully" }
    else  
      @title = "Edit goal"
      view_context.flash_failure
      render 'edit'
    end  
  end
  
  def destroy
    @goal.destroy
    redirect_to subject_path(@subject, student_group_id: @subject.student_group_id), 
                flash: { success: "Goal deleted successfully" }
  end
  
  # #methods
  
  def get_subject
    @subject = Subject.find(params[:subject_id])
  end
  
  def get_goal
    @goal = @subject.goals.find_by_id(params[:id])
  end

end
