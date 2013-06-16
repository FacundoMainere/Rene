Feature: Medical Office Cancel Turn
  In order to organize my appointments
  As a medical office
  I want to be able to cancel an upcoming appointment from the appointment list page

  Background:
    Given I am logged in

  @savesMedic
  Scenario: Happy path
    Given the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "roberto_r" was already booked by "cucumber_user"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "josefina_j" was already booked by "cucumber_user"
    And I am on "the medical office appointment list page"
    And I click on checkbox of "Hector Mendoza" appointment
    When I press "cancelTurnButton"
    Then I should see "Alvaro Ropereo"
    And I should not see "Hector Mendoza"
    And I should see "1" upcoming appointments
