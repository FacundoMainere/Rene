Feature: Patient Appointment List
  In order to organize my appointments
  As a patient
  I want to be able to see a list of my upcoming appointments

  Background:
    Given I am logged in

  @wip
  @savesMedic
  Scenario: No upcoming appointments
    Given I am on "the patient appointment list page"
    Then I should see "No hay turnos proximos."
  @wip
  @savesMedic
  Scenario: All the appointments are in the past
    Given I am on "the patient appointment list page"
    And the appointment with "Alvaro Ropereo" yesterday at "16:00" for "cucumber_user@someplace.com" was already booked by "roberto@rmail.com"
    And the appointment with "Jose Perez" yesterday at "12:00" for "cucumber_user@someplace.com" was already booked by "jose@jmail.com"
    Then I should see "No hay turnos proximos."
  @wip
  @savesMedic
  Scenario: Another patient is registered for some upcoming appointments
    Given I am on "the patient appointment list page"
    And the appointment with "Alvaro Ropereo" tomorrow at "12:00" for "pachano@pmail.com" was already booked by "jose@jmail.com"
    Then I should see "No hay turnos proximos."
  @wip
  @savesMedic
  Scenario: Happy path
    Given the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "cucumber_user@someplace.com" was already booked by "josefina@jmail.com"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "cucumber_user@someplace.com" was already booked by "roberto@rmail.com"
    And I am on "the patient appointment list page"
    Then I should see "2" upcoming appointments
    And I should see "Alvaro Ropereo"
    And I should see "Hector Mendoza"
