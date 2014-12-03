class RemoveColumnFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :starts_at, :datetime
  end
end
