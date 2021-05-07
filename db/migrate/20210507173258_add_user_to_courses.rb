class AddUserToCourses < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :user, null: false, foreign_key: true
  end
end
