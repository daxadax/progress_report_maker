class StudentsController < ApplicationController
  include IndexHelper

  before_filter :get_student_group, except: [:index] #in ApplicationController
  before_filter :get_student, except: [:index, :new, :create]    
  
  def index
    index_helper
    @title = "All students"
  end  

  def show
    @subjects = @student_group.subjects
    @evals = @student.evaluations
    @scores = []
    @title = "#{@student.name}"
  end
  
  def new    
    @student = @student_group.students.build
    @title = "Add a student"
  end
  
  def create
    @student = @student_group.students.create(params[:student])
    if @student.save
      # for now redirect to (later this should be the subject#new action)
      redirect_to group_path(@student_group, {id: @student_group.id}), flash: { success: "Student added successfully" }
    else
      @title = "Add a student"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'new' 
    end    
  end

  def edit
    @title = "Edit student"
  end

  def update
    if @student.update_attributes(params[:student])
      redirect_to group_path(@student_group, {id: @student_group.id}), flash: { success: "#{@student.name} updated successfully" }
    else  
      @title = "Edit student"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end
  
  def destroy
    @student.destroy
    redirect_to group_path(@student.student_group_id), flash: { success: "#{@student.name} has been deleted" }
  end

  #methods

  def get_student
    @student = @student_group.students.find(params[:id])
  end

end

