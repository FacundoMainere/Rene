Feature: Medical Office Cancel Turn
  In order to organize my appointments
  As a medical office
  I want to be able to cancel an upcoming appointment from the appointment list page

  Background:
    Given I am logged in
  @wip
  Scenario: Happy path
    Given the appointment with "Alvaro Ropereo" tomorrow at "13:00" for "roberto@rmail.com" was already booked by "cucumber_user@someplace.com"
    And the appointment with "Hector Mendoza" tomorrow at "12:00" for "josefina@jmail.com" was already booked by "cucumber_user@someplace.com"
    And I am on "the appointment list page"
    And I click cancel on "Hector Mendoza" appointment
    Then I should see "Alvaro Ropereo"
    And I should not see "Hector Mendoza"
    And I should see "1" upcoming appointments
