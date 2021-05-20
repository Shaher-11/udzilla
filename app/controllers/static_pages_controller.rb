class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:landing_page]
  def landing_page
    @courses = Course.all.limit(3)
    @latest_courses = Course.latest_courses
    @latest_good_reviews = Enrollment.latest_good_reviews
    @top_rated_courses = Course.top_rated_courses
    @popular_courses = Course.popular_courses
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def privacy_policy
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
