Feature: Patient Book Appointment
  In order to organize my appointments
  As a patient
  I want to be able to book appointments for me

  Background:
    Given I am logged in
	
	@savesMedic
  Scenario: Happy path
		Given the appointment with "Alvaro Ropereo" with date "2040-10-10" at "13:00" by "roberto_r"
    And the appointment with "Hector Mendoza" with date "2040-10-10" at "12:00" by "josefina_j"
    And I am on "the select office page"
		And I fill in "office" with "roberto_r"
		When I press "selectOfficeButton"
    And I select "Alvaro Ropereo" appointment
    When I press "bookAppointmentButton"
    Then I should see "Su reserva se ha realizado con éxito"
	
	@savesMedic
  Scenario: Patient already has an appointment at this time
    And the appointment with "Hector Mendoza" with date "2040-10-10" at "12:00" by "josefina_j"
		And the appointment with "Alvaro Ropereo" with date "2040-10-10" at "16:00" for "cucumber_user" was already booked by "roberto_r"
		And I am on "the select office page"
		And I fill in "office" with "roberto_r"
		When I press "selectOfficeButton"
    Then I should see "No hay turnos proximos."

