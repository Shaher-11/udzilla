class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: {:minimum => 10}
  validates :title, uniqueness: true, length: {:minimum => 10}
  validates :price, :numericality => {:greater_than_or_equal_to => 0}
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
  scope :published, -> { where(published: true)}
  scope :approved, -> { where(approved: true)}
  scope :unpublished, -> { where(upublished: false)}
  scope :unapproved, -> { where(approved: false)}

  has_one_attached :avatar
  validates :avatar, presence: true, 
  content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 900.kilobytes , message: 'Size should be less than 900 kilopytes' }

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

  def calculate_income
    update_column :income, (enrollments.map(&:price).sum)
    user.calculate_course_income
  end 

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
