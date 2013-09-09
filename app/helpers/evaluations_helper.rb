module EvaluationsHelper
  
  def number_params
    # if no student number is set, set = 1, and increment eval_number count
    if params[:student_number].nil?
      #  to set the student to be evaluated
      @student_number = 1 
      #  to create the "eval_number" attribute
      if Evaluation.last.nil?
        @current_eval = 1
      else
        @current_eval = Evaluation.last.set_eval_number
      end
    #   else student_number and eval_number are set from previous counts
    else
      @student_number = params[:student_number]
      @current_eval = Evaluation.last.eval_number
    end
  end
  
  def goals_by_subject
    @ids = []
    get_subject_ids = @subjects.each { |group, subjects| subjects.each { |subject| @ids << subject.id}}
    @goals = Goal.where('subject_id IN (?)', @ids)
  end
  
  def create_evaluations
    # create evaluation data for each goal using params[score_x]
    @goals.each do |goal|
      @evaluation = @student.evaluations.create(score: params["score_#{goal.id}"], 
                                                student_id: @student, 
                                                goal_id: goal.id,
                                                eval_number: @current_eval)
    end
  end
  
  def evaluation_save
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
  end
  
end
