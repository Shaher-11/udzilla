class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:landing_page]
  def landing_page
    @courses = Course.all.limit(3)
    @latest_courses = Course.latest_courses.published.approved
    @latest_good_reviews = Enrollment.latest_good_reviews
    @top_rated_courses = Course.top_rated_courses.published.approved
    @popular_courses = Course.popular_courses.published.approved
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def privacy_policy
  end

  def activity
    if current_user.has_role?(:admin)
      @activities = PublicActivity::Activity.all
    else
      redirect_to root_path, alert: "You are not authorized to access this page"
    end 
  end

  def analytics
    if current_user.has_role?(:admin)
      @enrollments = Enrollment.all
      @courses = Course.all
    else
      redirect_to root_path, alert: "You are not authorized to access this page"
  end
end 

end
