class AddIncomeToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :income, :integer, default: 0, null: false
  end
end
