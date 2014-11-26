class AddColorToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :color, :string
  end
end
