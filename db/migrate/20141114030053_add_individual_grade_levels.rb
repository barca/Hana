class AddIndividualGradeLevels < ActiveRecord::Migration
  def change
  	remove_column :lessons, :grade_level
  	add_column :lessons, :g1_3, :boolean
  	add_column :lessons, :g3_5, :boolean
  	add_column :lessons, :g6_8, :boolean
  end
end
