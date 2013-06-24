Feature: Load Patient Pending Appointment
  In order to organize my appointments
  As a medical office
  I want to be able to load patient pending appointments

  Background:
    Given I am logged in

	
  Scenario: Happy path
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "2015-10-10"
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Detalles del turno:"
    Then I should see "Dr/a.: Alvaro Ropereo"
    Then I should see "Fecha: 2015-10-10"
    Then I should see "Hora: 16:00"
    Then I should see "Duración: 20 minutos."

	@savesMedic
  Scenario: Appointment already booked
    Given I am on "the new patient pending appointment page"
    And the appointment with "Alvaro Ropereo" tomorrow at "16:00" for "josefina_j" was already booked by "cucumber_user"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "2015-10-10"
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Turno ya registrado. Ingrese un nuevo turno."

	@savesMedic
  Scenario: Date is invalid
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with yesterday
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."

	@savesMedic
  Scenario: Hour is invalid
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with today
    And I fill in "appointment[hour]" with a past hour
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."

	@savesMedic
  Scenario: Medic field is invalid
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Dr. Alvaro Ropereo 3"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El nombre debe contener solo letras."

	@savesMedic
  Scenario: Hour field format is invalid
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "19am"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El formato de hora debe ser HH:MM."

	@savesMedic
  Scenario: Date field format is invalid
    Given I am on "the new patient pending appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "July 6th"
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El formato de fecha debe ser aaaa-mm-dd."

