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
 | title        | instructor| grade_level | starts_at           | ends_at            | location        | max_enrollment | description |
 | Star Wars 101| Han Solo  | 1-3         | 2014-10-10 2:00:00  | 2014-10-10 2:10:00 |Gym              | 7              | A           |
 | Star Wars 102| luke      | 3-5         | 2014-10-11 3:00:00  | 2014-10-11 4:00:00 |Jedi Academy     | 7 	            | B	 	        |
 | Death star   | Darth     | 6-8         | 2014-10-12 4:00:00  | 2014-10-12 5:00:00 |not death star  | 7 	            | C	 	        |
 | Dancing      | Usher     | 6-8         | 2014-10-13 5:00:00  |  2014-10-13 6:00:00|Dance Studio     | 7 	            | D	      	  |

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
    When I go to New Lesson
    And I fill in "Title" with "Why Alex Drexler is Great"
    And I fill in "Instructor" with "Alex Drexler"
    And I select "3-5" from "Grade level" 
    And I select "Gym" from "Location"
    And I fill in "Max enrollment" with "14"
    And I press "Create Lesson"
    Then I should be on the show page for "Why Alex Drexler is Great"

  Scneario: set lessons to reoccur each week 
    When I go to New Lesson 
    And I fill in "Title" with "Drawing 101"
    And I fill in "Instructor" with "Picasso"
    And I select "3-5" from "Grade level" 
    And I select "Dance Studio" from "Location"
    And I fill in "Max enrollment" with "14"
    And I check "Reoccur every week on Tuesday"
    And I press "Create Lesson"
    And I press "Calendar"
    Then I should see "Drawing 101" on "November 4" and "November 11"

  Scenario: Sort Calendar by grade level 
     When I click "6-8" 
     Then I should see "Death star" and "Dancing" 
     And I should not see "Star Wars 101"

  Scenario: See Weekly View
     Given I create a lesson "Event 1" for "today" 
     And I create a lesson "Event 2" for "seven days from now"
     When I press "Weekly"
     Then I should see "Event 1"
     And I should not see "Event 2"




