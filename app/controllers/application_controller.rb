class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_global_variable, if: :user_signed_in?

  include PublicActivity::StoreController

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_global_variable
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
end
