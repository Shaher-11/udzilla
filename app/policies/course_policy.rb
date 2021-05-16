class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    @record.user.id == @user.id
  end

  def update?
    @record.user.id == @user.id
  end

  def new?
    @user.has_role?:teacher
  end

  def create?
    @user.has_role?:teacher
  end

  def destroy?
    @record.user.id == @user.id
  end
end
