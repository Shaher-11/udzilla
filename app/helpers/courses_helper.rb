module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Viw Analytics", course_path(course), class: 'btn btn-success text-white'
      elsif course.enrollments.where(user: current_user).any?
        link_to  course_path(course), class: 'btn btn-success text-white' do
          "<i class='text-white fas fa-spinner'></i>".html_safe + " " +
          number_to_percentage(course.progress(current_user), precision: 0)

        end
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-success text-white'
      else
        link_to "free", new_course_enrollment_path(course), class: 'btn btn-success text-white'
      end
    else
      link_to "Check Price", course_path(course), class: 'btn btn-success text-white'
    end
  end

  def review_button(course)
    user_course = course.enrollments.where(user: current_user)
    if current_user
      if user_course.any?
        if user_course.pending_review.any?
          link_to "Add Review", edit_enrollment_path(user_course.first), class: 'btn btn-primary text-white'
        else
          link_to "Reviewed", enrollment_path(user_course.first), class: 'btn btn-primary text-white'
        end
      end
    end
  end

end
