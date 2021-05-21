class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.present? && @user.has_role?(:admin) || @user.present? && @record.course.user_id == @user.id || @user.present? && @record.course.bought(@user) == false
  end

  def edit?
    @user.present? && @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def update?
    @record.course.user_id == @user.id
  end

  def new?
   # @user.has_role?:teacher
  end

  def create?
    @record.course.user_id == @user.id
  end

  def destroy?
    @user.present? && @user.has_role?(:admin) || @record.course.user_id == @user.id
  end
end
