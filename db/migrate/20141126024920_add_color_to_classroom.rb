class AddColorToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :color, :string
  end
end
