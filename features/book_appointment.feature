Feature: Book Appointments
  In order to organize my appointments
  As a medical office
  I want to be able to book appointments for my patients

  Scenario: Happy path
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Appointment was booked succesfully!"

  Scenario: Appointment already booked
    Given I am on "the new appointment page"
    And the appointment with "Alvaro Ropereo" the day "19/09/2013" at "16:00" with a duration of "20" minutes was already booked
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Appointment was already booked, select other appointment"

  Scenario: Date is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with yesterday
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Appointment is in the past"

  Scenario: Hour is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with today
    And I fill in "appointment[hour]" with a past hour
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Appointment is in the past"

  Scenario: Medic field is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Dr. Alvaro Ropereo 3"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Use only alphabetic characters"

  Scenario: Medic field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with ""
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: medic name is required"

  Scenario: Hour field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with ""
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: hour is required"

  Scenario: Hour field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "19am"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: hour format is 'hh:mm'"

  Scenario: Date field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "July 6th"
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: date format is 'dd/mm/yyyy'"

   Scenario: Date field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with ""
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: date is required"
