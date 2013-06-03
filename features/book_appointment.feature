Feature: Book Appointments
  In order to organize my appointments
  As a medical office
  I want to be able to book appointments for my patients

  Background:
    Given I am logged in
 
  @savesMedic
  Scenario: Happy path
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Detalles del turno:"

  @savesMedic
  Scenario: Appointment already booked
    Given I am on "the new appointment page"
    And the appointment with "Alvaro Ropereo" tomorrow at "16:00" with a duration of "20" minutes was already booked
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Turno ya registrado. Ingrese un nuevo turno."

  Scenario: Date is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with yesterday
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."

  Scenario: Hour is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with today
    And I fill in "appointment[hour]" with a past hour
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."

  Scenario: Medic field is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Dr. Alvaro Ropereo 3"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El nombre debe contener solo letras."

  Scenario: Medic field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with ""
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "16:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El campo 'Nombre de medico' es requerido."

   Scenario: Date field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with ""
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El campo 'Fecha' es requerido."
 
  Scenario: Hour field is blank
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with ""
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El campo 'Hora' es requerido."

  Scenario: Hour field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with tomorrow
    And I fill in "appointment[hour]" with "19am"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El formato de hora debe ser HH:MM."

  Scenario: Date field format is invalid
    Given I am on "the new appointment page"
    And I fill in "appointment[medic]" with "Alvaro Ropereo"
    And I fill in "appointment[date]" with "July 6th"
    And I fill in "appointment[hour]" with "19:00"
    And I fill in "appointment[duration]" with "20"
    When I press "saveButton"
    Then I should see "Error: El formato de fecha debe ser aaaa-mm-dd."

  
