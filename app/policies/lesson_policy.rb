class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def edit?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def update?
    @record.course.user_id == @user.id
  end

  def new?
   # @user.has_role?:teacher
  end

  def create?
   # @user.has_role?:teacher
  end

  def destroy?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end
end
