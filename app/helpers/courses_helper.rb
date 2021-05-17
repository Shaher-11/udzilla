module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Viw Analytics", course_path(course), class: 'btn btn-success text-white'
      elsif course.enrollments.where(user: current_user).any?
        link_to "Already Enrolled", course_path(course), class: 'btn btn-success text-white'
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-success text-white'
      else
        link_to "free", new_course_enrollment_path(course), class: 'btn btn-success text-white'
      end
    else
      link_to "Check Price", course_path(course), class: 'btn btn-success text-white'
    end
  end
end
