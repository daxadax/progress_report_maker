class EvaluationsController < ApplicationController
include IndexHelper
include EvaluationsHelper

  before_filter :get_student_group, except: :help
  before_filter :get_student, only: [:new, :create]
  
  def note
    @title = "Before you begin..."
  end
  
  def eval_fail
    @subjects = @student_group.subjects
    @title = "Woops!"
  end
   
  def new
    index_helper #inside index helper
    get_subjects 
    number_params #inside evaluation helper
    @evaluation = @student.evaluations.build
    render :layout => 'layouts/evaluation'
  end

  def create
    index_helper
    get_subjects
    @student_number = params[:student_number]
    @current_eval = params[:current_eval]
    #next two inside evaluation helper
    goals_by_subject 
    create_evaluations
    if @evaluation.save
      #inside evaluation helper
      evaluation_save
    # if the evaluation didn't save, start over with the same student
    else  
      flash.now[:error] = "Something's gone wrong.  Have you filled in a score for each goal?"
      render :new, student_number: @student_number, :layout => 'layouts/evaluation'
    end
  end

  def get_subjects
    @subjects = @subjects.select{|key, hash| key["id"] == @student_group.id}
  end
  
  def get_student
    @student = @student_group.students.find(params[:student_id])
  end

end