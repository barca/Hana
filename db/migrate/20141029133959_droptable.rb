class Droptable < ActiveRecord::Migration
  def down
  	drop_table :lessons
  end
end
