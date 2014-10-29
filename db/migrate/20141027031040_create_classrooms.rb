class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :max_enrollment
      t.text :details

      t.timestamps
    end
  end
end
