class Classroom < ActiveRecord::Base
	validates :name, presence: true
	validates :max_occupancy, numericality: { only_integer: true }
	validate :occupancy_not_negative

	def occupancy_not_negative
		if max_occupancy < 1
			errors.add(:max_occupancy, "must be a positive value")
		end
	end
end
