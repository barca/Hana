class Classroom < ActiveRecord::Base
	validates :name, presence: true
	validates :max_occupancy, numericality: { only_integer: true }
end
