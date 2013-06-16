Feature: Patient Cancel Turn
  In order to organize my appointments
  As a patient
  I want to be able to cancel an upcoming appointment from the appointment list page

  Background:
    Given I am logged in
  @wip
  @savesMedic
  Scenario: Happy path
    Given the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "cucumber_user" was already booked by "roberto_r"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "cucumber_user" was already booked by "josefina_j"
    And I am on "the patient appointment list page"
    And I click on checkbox of "Hector Mendoza" appointment
    Then I should see "Alvaro Ropereo"
    And I should not see "Hector Mendoza"
    And I should see "1" upcoming appointments
