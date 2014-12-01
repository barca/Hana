class AddEndsAtToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :ends_at, :time
  end
end
