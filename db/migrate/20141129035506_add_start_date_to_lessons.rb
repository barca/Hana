class AddStartDateToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :start_date, :date
  end
end
