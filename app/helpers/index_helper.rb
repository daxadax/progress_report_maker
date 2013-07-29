module IndexHelper
  
  def index_helper
    # get :id of each :student_group that belongs_to current_user
    # http://stackoverflow.com/a/17835000/2128691 
    @user_group_ids = current_user.student_groups.map(&:id)
  
    # fetch associated models from student_group
    # http://stackoverflow.com/a/17904396/2128691
  
    # get all subjects from each of the user's student_groups
    get_subjects = Subject.where('student_group_id IN (?)', @user_group_ids).includes(:student_group)
  
    # get all students from each of the user's student_groups
    get_students = Student.where('student_group_id IN (?)', @user_group_ids).includes(:student_group) 
  
    # sort
    # http://stackoverflow.com/a/10083791/2128691
  
    # sort subjects by student_group
    subjects_by_group = get_subjects.uniq {|s| s.student_group_id}
    @subjects = subjects_by_group.group_by { |s| s.student_group }
  
    # sort students by student_group
    students_by_group = get_students.uniq {|s| s.student_group_id}
    @students = students_by_group.group_by { |s| s.student_group }
  end
  
end