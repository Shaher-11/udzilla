class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @record.published && @record.approved ||
    @user.present? && @user.has_role?(:admin) || 
    @user.present? && @record.user_id == @user.id || 
    @user.present? && @record.bought(@user)
  end

  def edit?
    @user.present? && @user.has_role?(:admin) || @user.present? && @record.user.id == @user.id
  end

  def update?
    @user.present? && @user.has_role?(:admin) || @user.present? && @record.user.id == @user.id
  end

  def new?
    @user.has_role?(:teacher)
  end

  def create?
    @user.has_role?(:teacher)
  end

  def destroy?
    @user.present? && @user.has_role?(:admin) || @user.present? && @record.user.id == @user.id
  end

  def approve?
    @user.present? && @user.has_role?(:admin) 
  end
  
  def owner?
    @record.user == @user
  end
end
