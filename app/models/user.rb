class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  rolify
  
  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end
  
  has_many :courses

  after_create :assign_default_role

  def assign_default_role
    if User.count == 0
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher)
    end
  end

  validate :must_have_a_role, on: :update

  private

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "The user must have a least one role")
    end
  end

<<<<<<< HEAD

=======
>>>>>>> a025a634e58cd416ea4f6fa79f9bff85dd88d591
end
