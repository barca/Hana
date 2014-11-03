Feature: Add/Edit Lessons 

  As an administrator
  I want to create a lesson with   the following information:
  - Title
  - Instructor
  - Grade level
  - Day and time
  - Room location
  - Max enrollment
  - Description
  So that I have all pertinent information and can access and edit at another time.
  Background: classes Instruction database

      Given the following lessons exist:
 | title        | instructor| grade_level | starts_at               | location        | max_enrollment | description |
 | Star Wars 101| Han Solo  | 1-3         | 10/10/2014 2:00:00 P.M. | galaxy far away | 7              | |
 | Star Wars 102| luke      | 3-5         | 10/11/2014 2:00:00 P.M. | jedi academy    | 7 		 | |
 | Death star   | Darth     | 6-8         | 10/12/2014 2:00:00 P.M. | not death star  | 7 		 | |
 | Dancing      | Usher     | 6-8         | 10/13/2014 2:00:00 P.M. | galaxy away     | 7 		 | |


  Scenario: add instructor to existing class
    When I go to the edit classss for "Star Wars 102"
    And  I fill in "Instructor" with "Han Solo"
    And  I press "Update Class Info"
    Then the instructor of "Star Wars 102" should be "Han Solo"

  Scenario: edit a location for an existing   class(sad path)
    When I go to the edit class for "Star Wars 101"
    And  I fill in "Location" with ""
    And  I press "Update Class Info"
    Then I should see an error message

  Scenario: creating new class
    When I press “Add Class”
    And I fill in “Title” with “Why Alex Drexler is Great”
    And I fill in “Instructor” with “Alex Drexlerer”
    And I fill in “Grade Level” with “3-5”
    And I fill in ""Time” with “Monday 3:00 - 3:30”
    And I fill in “Location” withth “Dance Studio”
    And I fill in “Max Enrollment” with “14”
    Then I should see “Why Alex Drexler is Great” on the Calendar page



