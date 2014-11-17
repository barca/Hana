class AddingRepeatDays < ActiveRecord::Migration
  def change
  	add_column :lessons, :mon, :boolean
  	add_column :lessons, :tue, :boolean
  	add_column :lessons, :wed, :boolean
  	add_column :lessons, :thu, :boolean
  	add_column :lessons, :fri, :boolean
  	add_column :lessons, :end_date, :date
  end
end
