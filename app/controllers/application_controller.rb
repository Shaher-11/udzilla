class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :set_global_variable, if: :user_signed_in?
  def set_global_variable
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
  end
end
