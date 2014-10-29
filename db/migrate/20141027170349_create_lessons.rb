class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :instructor
      t.string :grade_level
      t.string :day_and_time
      t.string :location
      t.string :max_enrollment
      t.text :description

      t.timestamps
    end
  end
end
