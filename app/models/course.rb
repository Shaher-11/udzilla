class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: {:minimum => 10}
  belongs_to :user
  def to_s
    title
  end
  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  LANGUAGES = [:"English", :"Arabic", :"French", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language]}
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
end
