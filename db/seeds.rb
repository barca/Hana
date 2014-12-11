# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


@classroom = Classroom.create(name: 'Gym', max_occupancy: 100, details: "", created_at: '2014-12-10',updated_at: '2014-12-10', color: 'yellow')
@classroom.save

@lesson = Lesson.create(title: 'Lesson A', instructor: 'Mr. T', location: "Gym", max_enrollment: 20, description: '', created_at: '2014-12-10 12:00:00',
 updated_at: '2014-12-10 12:00:01', g1_3: true, g3_5: false, g6_8: false, mon: true, tue: false, wed: true, thu: false, fri: false, end_date: '2014-12-30',
 color: 'yellow', starts_at: '08:00:00', ends_at: '09:00:00', start_date: '2014-12-10')
@lesson.save


