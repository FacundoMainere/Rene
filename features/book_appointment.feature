Feature: Book Appointments
  In order to organize my appointments
  As a medical office
  I want to be able to book appointments for my patients

  Background:
    Given I am logged in
 
  Scenario: Happy path
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Detalles del turno:"
 
  @wip @savesMedic
  Scenario: Appointment already booked
    Given I am on "the new appointment page"
    And the appointment with "Alvaro Ropereo" the day "2013-09-01" at "16:00" with a duration of "20" minutes was already booked
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Turno ya registrado. Ingrese un nuevo turno."
 
  @wip
  Scenario: Date is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with yesterday
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Appointment is in the past"
 
  @wip
  Scenario: Hour is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with today
    And I fill in "appointment[hour]" with a past hour
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Appointment is in the past"
 
  @wip
  Scenario: Medic field is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Dr. Alvaro Ropereo 3"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Use only alphabetic characters"
  
  @wip
  Scenario: Medic field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with ""
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: medic name is required"
  
  @wip
  Scenario: Hour field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with ""
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: hour is required"
 
  @wip
  Scenario: Hour field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "19am"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: hour format is 'hh:mm'"
 
  @wip
  Scenario: Date field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "July 6th"
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: date format is 'yyyy-mm-dd'"

  @wip
  Scenario: Date field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with ""
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: date is required"
