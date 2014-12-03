module ClassroomsHelper
	def get_available_classrooms(day,start,finish)
		classrooms = Classroom.all
		available_classrooms = classrooms.where()
	end
end
