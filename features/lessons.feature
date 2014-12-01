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

     And the following lessons exist:
 | title        | instructor| g1_3 | g3_5 | g6_8  | starts_at           | ends_at            | location        | max_enrollment         | description | mon  | end_date   | color | start_date| 
 | Star Wars 101| Han Solo  | false| true | true  | 2013-10-10 2:00:00  | 2013-10-10 3:00:00 |Gym              | 7                      | A           | true | 2013-10-10 | Red| 2013-10-10|
 | Star Wars 102| luke      | true | false| true  | 2013-10-11 3:00:00  | 2013-10-11 4:00:00 | Gym             | 7                      | B           | true | 2014-12-30 | Red|2013-10-11|
 | Death star   | Darth     | true |false | false |  2013-10-12 4:00:00 | 2013-10-12 5:00:00 | Dance Studio    | 7                      | C           | true | 2014-12-30 | blue |2013-10-12|
 | Dancing      | Usher     | true | false| false | 2013-10-13 5:00:00  |  2013-10-13 6:00:00| Dance Studio    | 7                      | D           | true | 2014-12-30 | blue|2013-10-13|

  Scenario: ITERATION 1- edit a location for an existing class(sad path)
    When I go to the edit lessons page for "Star Wars 101"
    And  I select "" from "Location"
    And  I press "Update Lesson"
    Then I should see "Location can't be blank"

  Scenario:ITERATION 1- add instructor to existing lesson
    When I go to the edit lessons page for "Star Wars 102"
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
    And I press "Create Lesson"
    Then I should be on the show page for "Why Alex Drexler is Great"

  Scenario:ITERATION 2- See Lessons by grade level
     When I go to the home page
     Then I should locate "Star Wars 101" in "calendar35"
     And I should not locate "Star Wars 102" in "calendar35"

  Scenario:ITERATION 2- See Weekly View
     When I go to the home page
     And I click "View Current Week"
     Then I should witness today
     And I should not witness seven days from today

  Scenario:ITERATION 2- Create Repeating Classes
     When I go to the edit lessons page for "Star Wars 101"
     And I check "lesson_tue"
     And I check "lesson_thu"
     And I press "Update Lesson"
     And I click "Calendar"
     Then I should locate "Star Wars 101" in "calendar68"
     And I should not locate "Star Wars 101" in "calendar13"

  Scenario: ITERATION 3- Color coded lesson in calendar view
    When I go to the home page
    Then the color of "Star Wars 102" in "calendar13" should be "Red"

  Scenario: ITERATION 3- See available classrooms during Lesson Creation
    When I go to the edit lessons page for "Dancing"
    And I select "2013" from "lesson_start_date_1i"
    And I select "October" from "lesson_start_date_2i"
    And I select "12" from "lesson_start_date_3i"
    And I select "04 AM" from "lesson_starts_at_4i"
    And I select "00" from "lesson_starts_at_5i"
    And I select "05 PM" from "lesson_ends_at_4i"
    And I select "00" from "lesson_ends_at_5i"    
    And I click "See Available Classrooms"
    Then I should see "Computer Lab"
    But I should not see "Dance Studio" at all 

  Scenario: ITERATION 3- See Unused classrooms in Calendar view
    When I go to the home page
    Then on "2013-10-10" I should see "Computer Lab"
    But I should not see "Gym"

  Scenario: ITERATION 3- Gracefully fail when I try to make the end time earlier than start time 
    When I go to New Lessons
    And I select "2013" from "lesson_start_date_1i"
    And I select "October" from "lesson_start_date_2i"
    And I select "12" from "lesson_start_date_3i"
    And I select "04 AM" from "lesson_starts_at_4i"
    And I select "00" from "lesson_starts_at_5i"
    And I select "01 AM" from "lesson_ends_at_4i"
    And I select "00" from "lesson_ends_at_5i"
    And I select "Red" from "Color"
    And I press "Create Lesson"
    Then I should see "Ends at can't be before Starts at"
    But I should not see "Lesson was successfully created"




