module StudentGroupsHelper
  
  def create_students
    @params.each do |student|
      @student_group.students.create(name:"#{student[:name]}", gender: "#{student[:gender]}")
    end
  end
  
end
