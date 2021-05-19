class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:landing_page]
  def landing_page
    @courses = Course.all.limit(3)
    @latest_courses = Course.all.limit(3).order(created_at: :desc)
    @latest_good_reviews = Enrollment.reviewed.limit(3).order(rating: :desc, created_at: :desc).limit(3)
    @top_rated_courses = Course.order(average_rating: :desc, created_at: :desc).limit(3)
    @popular_courses = Course.order(enrollments_count: :desc, created_at: :desc).limit(3)
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def privacy_policy
  end

  def activity
    @activities = PublicActivity::Activity.all
  end
end
