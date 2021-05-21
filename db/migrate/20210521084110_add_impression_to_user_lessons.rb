class AddImpressionToUserLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :user_lessons, :impression, :integer, default: 0, null: false
  end
end
