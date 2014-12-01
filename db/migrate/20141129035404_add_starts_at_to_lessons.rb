class AddStartsAtToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :starts_at, :time
  end
end
