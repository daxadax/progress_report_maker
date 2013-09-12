class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def get_student_group
    @user = current_user
    @student_group = @user.student_groups.find(params[:student_group_id])
  end 
  
end
