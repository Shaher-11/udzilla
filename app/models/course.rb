class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: {:minimum => 10}
  def to_s
    title
  end
end
