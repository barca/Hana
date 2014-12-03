class RemoveEndsAtFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :ends_at, :datetime
  end
end
