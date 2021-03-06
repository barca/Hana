class Classroom < ActiveRecord::Base
	has_many :lessons
	validates :name, presence: true
	validate :occupancy_not_negative

	def occupancy_not_negative
		if max_occupancy == nil || max_occupancy < 1
			errors.add(:max_occupancy, "must be a positive value")
		end
	end
end
