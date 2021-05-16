class AddSlugToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :slug, :string
    add_index :lessons, :slug, unique: true
  end
end
