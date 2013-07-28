class StudentsController < ApplicationController

  before_filter :get_student_group, except: [:index]
  before_filter :get_student, except: [:index, :new, :create]    
  
  def index
    # http://stackoverflow.com/a/17835000/2128691
    @user_group_ids = current_user.student_groups.map(&:id)
    # http://stackoverflow.com/a/17904396/2128691
    get_students = Student.where('student_group_id IN (?)', @user_group_ids).includes(:student_group)
    # http://stackoverflow.com/a/10083791/2128691
    students_by_group = get_students.uniq {|s| s.student_group_id}
    @students = students_by_group.group_by { |s| s.student_group }
    @title = "All students"
  end  

  def show
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
      redirect_to class_path(@student_group, {id: @student_group.id}), flash: { success: "Student added successfully" }
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
      redirect_to class_path(@student_group, {id: @student_group.id}), flash: { success: "#{@student.name} updated successfully" }
    else  
      @title = "Edit student"
      flash.now[:error] = "Something's gone wrong.  Please try again!"
      render 'edit'
    end  
  end
  
  def destroy
    @student.destroy
    redirect_to class_path(@student.student_group_id), flash: { success: "#{@student.name} has been deleted" }
  end

  #methods
  
  def get_student_group
    @user = current_user
    @student_group = @user.student_groups.find(params[:student_group_id])
  end

  def get_student
    @student = @student_group.students.find(params[:id])
  end

end

