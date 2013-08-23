class EvaluationsController < ApplicationController
include IndexHelper

  before_filter :get_student_group, except: :help
  
  def note
    @title = "Before you begin..."
  end
  
  def eval_fail
    @subjects = @student_group.subjects
    @title = "Woops!"
  end
   
  def new
    index_helper
    @subjects = @subjects.select{|key, hash| key["id"] == @student_group.id}
    @student = @student_group.students.find(params[:student_id])
    if params[:student_number].nil? 
      @student_number = 1 
    else
      @student_number = params[:student_number]
    end  
    @evaluation = @student.evaluations.build
    render :layout => 'layouts/evaluation'
  end
    
  def create
    index_helper
    @student = @student_group.students.find(params[:student_id])
    @student_number = params[:student_number]
    @subjects = @subjects.select{|key, hash| key["id"] == @student_group.id}
    @ids = []
    get_subject_ids = @subjects.each { |group, subjects| subjects.each { |subject| @ids << subject.id}}
    @goals = Goal.where('subject_id IN (?)', @ids)
    # create evaluation data for each goal using params[score_x]
    @goals.each do |goal|
      @evaluation = @student.evaluations.create(score: params["score_#{goal.id}"], 
                                                student_id: @student, 
                                                goal_id: goal.id)
    end
    if @evaluation.save
      # increment student_number
      @student_number = (@student_number.to_i + 1)
      # if no students are left, stop
      if @student_number > @student_group.students.count
        redirect_to groups_path, 
                    flash: { success: "Congratulations, 
                                       you've completed the evaluation of 
                                       #{@student_group.name}!" }
      # if there are still students, keep going
      else
        redirect_to evaluate_path({ student_group_id: @student_group, 
                                    student_id: @student.next, 
                                    student_number: @student_number })
      end
    # if the evaluation didn't save, start over with the same student
    else  
      flash.now[:error] = "Something's gone wrong.  Have you filled in a score for each goal?"
      render :new, student_number: @student_number, :layout => 'layouts/evaluation'
    end
  end

end
