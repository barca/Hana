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
 | title        | instructor| g1_3 | g3_5 | g6_8    | starts_at           | ends_at            | location        | max_enrollment | description | mon |
 | Star Wars 101| Han Solo  | false | true| false  | 2013-10-10 2:00:00  | 2014-10-10 2:10:00 |Gym              | 7               | A           | true|
 | Star Wars 102| luke      | true  | false| true  | 2013-10-11 3:00:00  | 2014-10-11 4:00:00 |Jedi Academy     | 7 	            | B	 	        | true| 
 | Death star   | Darth     | true  |false | false |  2013-11-16 4:00:00 | 2014-10-12 5:00:00 |not death star   | 7 	            | C	   	      | true|
 | Dancing      | Usher     | true  | false | false | 2014-10-13 5:00:00  |  2014-10-13 6:00:00|Dance Studio     | 7 	            | D	      	  | true| 

     And the following classrooms exist: 

     |name | max_occupancy | details | 
     |Gym  | 14            |         | 
     |Dance Studio | 20    |         | 

  Scenario: edit a location for an existing class(sad path)
    When I go to the edit lessons page for "Star Wars 101"
    And  I select "" from "Location"
    And  I press "Update Lesson"
    Then I should see "Location can't be blank"

  Scenario: add instructor to existing lesson
    When I go to the edit lessons page for "Star Wars 102"
    And  I fill in "Instructor" with "Han Solo"
    And  I press "Update Lesson"
    Then the instructor of "Star Wars 102" should be "Han Solo"

  Scenario: creating new lesson
    When I go to New Lessons
    And I fill in "Title" with "Why Alex Drexler is Great"
    And I fill in "Instructor" with "Alex Drexler"
    And I check "lesson_g1_3" 
    And I select "Gym" from "Location"
    And I fill in "Max enrollment" with "14"
    And I press "Create Lesson"
    Then I should be on the show page for "Why Alex Drexler is Great"

  Scenario: set lessons to reoccur each week 
    When I go to New Lessons
    And I fill in "Title" with "Drawing 101"
    And I fill in "Instructor" with "Picasso"
    And I check "lesson_g3_5" 
    And I select "Dance Studio" from "Location"
    And I fill in "Max enrollment" with "14"
    And I check "lesson_wed"
    And I check "lesson_fri"
    And I press "Create Lesson"
    And I click "Calendar"
    Then I should view "Drawing 101" every "Tuesday" and "Friday"

  Scenario: See Lessons by grade level 
     When I go to the home page 
     Then I should locate "Star Wars 101" in "calendar35" 
     And I should not locate "Star Wars 102" in "calendar35"

  Scenario: See Weekly View
     When I go to the home page 
     And I click "View Current Week"
     Then I should witness today 
     And I should not witness seven days from today 




