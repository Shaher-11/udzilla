class CreateUserLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :user_lessons do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
