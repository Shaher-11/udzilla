class AddPublishedAndApprovedToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :published, :boolean, default: false
    add_column :courses, :approved, :boolean, default: false
  end
end
