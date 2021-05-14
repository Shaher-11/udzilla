class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

<<<<<<< HEAD
=======

>>>>>>> a025a634e58cd416ea4f6fa79f9bff85dd88d591
  def edit?
    @user.has_role?:admin 
  end

  def update?
    @user.has_role?:admin 
  end

<<<<<<< HEAD

=======
>>>>>>> a025a634e58cd416ea4f6fa79f9bff85dd88d591
end
