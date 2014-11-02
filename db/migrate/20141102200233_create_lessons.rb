class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :instructor
      t.string :grade_level
      t.datetime :start_at
      t.datetime :ends_at
      t.string :location
      t.integer :max_enrollment
      t.text :description

      t.timestamps
    end
  end
end
