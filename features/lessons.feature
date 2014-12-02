Feature: Add/Edit Lessons

  As an administrator
  I want to create a lesson with the following information:
  - Title
  - Instructor
  - Grade level
  - Day and time
  - Room location
  - Max enrollment
  - Description
  So that I have all pertinent information and can access and edit at another time.
  Background: classes Instruction database

      Given the following classrooms exist:

     |name         | max_occupancy | details | color|
     |Gym          | 14            |         | Red  |
     |Dance Studio | 20            |         | blue |
     |Computer Lab | 40            |         | green|
     |Unused Room  | 50            |         | olive| 

     And the following lessons exist:
 | title        | instructor| g1_3 | g3_5 | g6_8  | starts_at           | ends_at            | location        | max_enrollment         | description | mon  | end_date   | color | start_date|
 | Star Wars| Han Solo  | false| true | false  | 2013-10-10 2:00:00  | 2013-10-10 3:00:00 |Gym              | 7                      | A           | true | 2014-12-30 | Red| 2013-10-10|
 | Star Wars102| luke      | true | false| true  | 2013-10-11 3:00:00  | 2013-10-11 4:00:00 | Gym             | 7                      | B           | true | 2014-12-30 | Red|2013-10-11|
 | Death star   | Darth     | true |false | false |  2013-10-12 4:00:00 | 2013-10-12 5:00:00 | Dance Studio    | 7                      | C           | true | 2014-12-30 | blue |2013-10-12|
 | Dancing      | Usher     | true | false| false | 2013-10-13 5:00:00  |  2013-10-13 6:00:00| Dance Studio    | 7                      | D           | true | 2014-12-30 | blue|2013-10-13|

  Scenario: ITERATION 1- edit a location for an existing class(sad path)
    When I go to the edit lessons page for "Star Wars"
    And  I select "" from "Location"
    And  I press "Update Lesson"
    Then I should see "Location can't be blank"

  Scenario:ITERATION 1- add instructor to existing lesson
    When I go to the edit lessons page for "Star Wars102"
    And  I fill in "Instructor" with "Han Solo"
    And  I press "Update Lesson"
    Then the instructor of "Star Wars 102" should be "Han Solo"

  Scenario:ITERATION 1- creating new lesson
    When I go to New Lessons
    And I fill in "Title" with "Why Alex Drexler is Great"
    And I fill in "Instructor" with "Alex Drexler"
    And I check "lesson_g1_3"
    And I select "Gym" from "Location"
    And I fill in "Max enrollment" with "14"
    And I set lesson start at to "2013-December-14" "08 AM:00"
    And I set lesson end time to "9 AM:00"
    And I press "Create Lesson"
    Then I should be on the show page for "Why Alex Drexler is Great"

  Scenario:ITERATION 2- set lessons to reoccur each week
    When I go to New Lessons
    And I fill in "Title" with "Drawing"
    And I fill in "Instructor" with "Picasso"
    And I check "lesson_g3_5"
    And I select "Dance Studio" from "Location"
    And I fill in "Max enrollment" with "5"
    And I set lesson start at to "2013-December-2" "08 AM:00"
    And I set lesson end time to "9 AM:00"
    And I select "2014" from "lesson_end_date_1i"
    And I select "December" from "lesson_end_date_2i"
    And I select "30" from "lesson_end_date_3i"
    And I check "lesson_wed"
    And I check "lesson_fri"
    And I press "Create Lesson"
    And I click "Back"
    Then I should locate "Drawing" in "calendar35"
    And I should not locate "Drawing" in "calendar13"

  Scenario:ITERATION 2- See Lessons by grade level
     When I go to the home page
     Then I should locate "Star Wars" in "calendar13"
     And I should not locate "Star Wars102" in "calendar35"

  Scenario:ITERATION 2- See Weekly View
     When I go to the home page
     And I click "View Current Week"
     Then I should witness today
     And I should not witness seven days from today

  Scenario:ITERATION 2- Create Repeating Classes
     When I go to the edit lessons page for "Star Wars"
     And I check "lesson_tue"
     And I check "lesson_thu"
     And I press "Update Lesson"
     And I click "Back"
     Then I should locate "Star Wars" in "calendar35"
     And I should not locate "Star Wars" in "calendar13"

  Scenario: ITERATION 3- Color coded lesson in calendar view
    When I go to the home page
    Then the color of "Star Wars102" in "calendar13" should be "Red"

  Scenario: ITERATION 3- Gracefully fail when I try to end before it begins
    When I go to the edit lessons page for "Dancing"
    And I set lesson start at to "2013-September-10" "06 PM:00"
    And I set lesson end time to "3 PM:00"
    And I press "Update Lesson"
    Then I should see "Ends at can't be before starts time"
    But I should not see "Lesson was successfully created"

  Scenario: ITERATION 3- Create a classroom with color 
    When I go to the home page 
    And I click "Classrooms"
    And I click "New Classroom"
    And I fill in "classroom_name" with "Multi Purpose Room"
    And I fill in "classroom_max_occupancy" with "100"
    And I select "violet" from "classroom_color"
    And I press "Create Classroom"
    And I click "Back"
    Then I should see "Multi Purpose Room"

  Scenario: ITERATION 3- Reorder clasrooms by occupancy and then alphabetically
    When I go to the classrooms page 
    And I click "Name"
    Then I should see a reordering of "Computer Lab" before "Gym"
    When I click "Max occupancy"
    Then I should see a reordering of "Gym" before "Computer Lab"
    When I click the first "Delete"
    Then I should not see "Gym"
    And I should see "Classroom was successfully destroyed"
  
  Scenario: ITERATION 3- See available classrooms during Lesson Creation
    When I go to the edit lessons page for "Dancing"
    And I set lesson start at to "2014-December-1" "3 PM:00"
    And I set lesson end time to "5 PM:00"
    And I click "See Available Classrooms"
    Then I should see "Unused Room"
    But I should not see "Gym"






