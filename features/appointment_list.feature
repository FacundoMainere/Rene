Feature: Appointment List
  In order to organize my appointments
  As a medical office
  I want to be able to see a list of my upcoming appointments
  Background:
    Given I am logged in
  @wip
  Scenario: No upcoming appointments
    Given I am on "the appointment list page"
    Then I should see "No hay turnos proximos."

  @wip
  Scenario: All the appointments are in the past
    Given I am on "the appointment list page"
    And the appointment with "Alvaro Ropereo" yesterday at "16:00" for "roberto@rmail.com" was already booked by "cucumber_user"
    And the appointment with "Alvaro Ropereo" yesterday at "12:00" for "josefina@jmail.com" was already booked by "cucumber_user"
    Then I should see "No hay turnos proximos."

  @wip
  Scenario: Another user registered some upcoming appointments
    Given I am on "the appointment list page"
    And the appointment with "Alvaro Ropereo" tomorrow at "12:00" for "josefina@jmail.com" was already booked by "other_user"
    Then I should see "No hay turnos proximos."

  @wip
  Scenario: Happy path
    Given I am on "the appointment list page"
    And the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "roberto@rmail.com" was already booked by "cucumber_user"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "josefina@jmail.com" was already booked by "cucumber_user"
    Then I should see "2" upcoming appointments
    And I should see "Alvaro Ropereo"
    And I should see "Hector Mendoza"
