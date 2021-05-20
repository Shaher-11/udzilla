class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: {:minimum => 10}
  validates :title, uniqueness: true
  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  def to_s
    title
  end
  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :latest_courses, -> { limit(3).order(created_at: :desc) }
  scope :top_rated_courses, -> { limit(3).order(average_rating: :desc, created_at: :desc)}
  scope :popular_courses, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }

  LANGUAGES = [:"English", :"Arabic", :"French", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language]}
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end

  def progress(user)
    unless self.lessons_count.zero?
      user_lessons.where(user: user).count/self.lessons_count.to_f*100
  end
end


  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
