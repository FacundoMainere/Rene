Feature: Patient Appointment List
  In order to organize my appointments
  As a patient
  I want to be able to see a list of my upcoming appointments

  Background:
    Given I am logged in

  @savesMedic
  Scenario: No upcoming appointments
    Given I am on "the patient appointment list page"
    Then I should see "No hay turnos proximos."

  @savesMedic
  Scenario: All the appointments are in the past
    Given the appointment with "Alvaro Ropereo" yesterday at "16:00" for "cucumber_user" was already booked by "roberto_r"
    And the appointment with "Jose Perez" yesterday at "12:00" for "cucumber_user" was already booked by "jose_j"
    And I am on "the patient appointment list page"
    Then I should see "No hay turnos proximos."

  @savesMedic
  Scenario: Another patient is registered for some upcoming appointments
    Given I am on "the patient appointment list page"
    And the appointment with "Alvaro Ropereo" tomorrow at "12:00" for "pachano" was already booked by "jose_j"
    Then I should see "No hay turnos proximos."

  @savesMedic
  Scenario: Happy path
    Given the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "cucumber_user" was already booked by "josefina_j"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "cucumber_user" was already booked by "roberto_r"
    And I am on "the patient appointment list page"
    Then I should see "2" upcoming appointments
    And I should see "Alvaro Ropereo"
    And I should see "Hector Mendoza"
