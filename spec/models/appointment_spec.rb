require 'spec_helper'
require 'date'

describe Appointment do

  describe 'add_new_appointment' do
    it "should create a new instance of an appointment with the right medic name" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment.medic.should eq 'Roberto Bolanios'
    end
    it "should create a new instance of an appointment with the right date" do
      now=DateTime.now
      entered_date_and_time=DateTime.new(now.year,now.month,now.day+1,19,0,0,0)
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment.date_and_hour.should eq entered_date_and_time
    end
    it "should create a new instance of an appointment with the right duration" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment.duration.should eq 20
    end
  end
  describe 'check_date' do

    it 'should return false if date is before today' do
      appointment=Appointment.new
      appointment.date_and_hour=DateTime.now-1
      appointment.check_date.should be false
    end

    it 'should return true if date is today in two hours' do
      today=DateTime.now+2.hours
      appointment=Appointment.new
      appointment.date_and_hour=today
      appointment.check_date.should be true
    end

    it 'should return true if date is after today' do
      appointment=Appointment.new
      appointment.date_and_hour=DateTime.now+1
      appointment.check_date.should be true
    end
  end
  describe 'capitalize_name' do
    it 'should return the same name when name is already capitalized' do
      appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1, 19, 0, 20, "patient_email@email.com", "user_friendly_name@email.com")
      appointment.medic.should eq 'Roberto Bolanios'
    end
    it 'should return Roberto Bolanios when name is uppercase' do
      appointment=Appointment.add_new_appointment('ROBERTO BOLANIOS',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      appointment.medic.should eq 'Roberto Bolanios'
    end
    it 'should return Roberto Bolanios when name is downcase' do
      appointment=Appointment.add_new_appointment('roberto bolanios',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      appointment.medic.should eq 'Roberto Bolanios'
    end
    it 'should return Roberto Bolanios when name is mixed case' do
      appointment=Appointment.add_new_appointment('RobertO BOlanIos',DateTime.now+1,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      appointment.medic.should eq 'Roberto Bolanios'
    end
  end
  describe 'overlaps' do
    it 'should be true when appointments start at the same hour but ends at different hour' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment=Appointment.new
      new_appointment.medic = 'Roberto Bolanios'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.overlaps(appointment).should be true
    end

    it 'should be true when an appointment time lapse is included in the other appointment time lapse' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment=Appointment.new
      new_appointment.medic = 'Roberto Bolanios'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,10,0,0)
      new_appointment.duration = 5
      new_appointment.overlaps(appointment).should be true
    end

    it 'should be true when appointments ends at the same hour but starts at different hour' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment=Appointment.new
      new_appointment.medic = 'Roberto Bolanios'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,10,0,0)
      new_appointment.duration = 10
      new_appointment.overlaps(appointment).should be true
    end

    it 'should be false when appointments time lapses doesnt include each other even partially' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      new_appointment=Appointment.new
      new_appointment.medic = 'Roberto Bolanios'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,20,0,0,0)
      new_appointment.duration = 30
      new_appointment.overlaps(appointment).should be false
    end
  end

  describe 'check_patient_is_available' do
    it 'should be true when patient does not already have an appointment for selected date and hour' do
      tomorrow=DateTime.now+1
      Appointment.should_receive(:all).with(:patient_name => 'patient_email@email.com').and_return([])
      new_appointment=Appointment.new
      new_appointment.medic = 'Hector Medina'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.patient_name = "patient_email@email.com"
      new_appointment.check_patient_is_available().should be true
    end

    it 'should be false when patient already have an appointment for selected date and hour' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      Appointment.should_receive(:all).with(:patient_name => 'patient_email@email.com').and_return([appointment])
      new_appointment=Appointment.new
      new_appointment.medic = 'Hector Medina'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.patient_name = "patient_email@email.com"
      new_appointment.check_patient_is_available().should be false
    end
  end
  describe 'check turn is taken' do
    it 'should be true when patient does not already have an appointment for selected date and hour' do
      tomorrow=DateTime.now+1
      Appointment.should_receive(:all).with(:medic => 'Hector Medina', :user_friendly_name => 'user_friendly_name@email.com').and_return([])
      new_appointment=Appointment.new
      new_appointment.medic = 'Hector Medina'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.patient_name = "patient_email@email.com"
      new_appointment.user_friendly_name = "user_friendly_name@email.com"
      new_appointment.check_turn_is_taken().should be true
    end

    it 'should be false when patient already have an appointment for selected date and hour' do
      tomorrow=DateTime.now+1
      appointment=Appointment.add_new_appointment('Roberto Bolanios',tomorrow,19,0,20, "patient_email@email.com", "user_friendly_name@email.com")
      Appointment.should_receive(:all).with(:medic => 'Hector Medina', :user_friendly_name => 'user_friendly_name@email.com').and_return([appointment])
      new_appointment=Appointment.new
      new_appointment.medic = 'Hector Medina'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.patient_name = "patient_email@email.com"
      new_appointment.user_friendly_name = "user_friendly_name@email.com"
      new_appointment.check_turn_is_taken().should be false
    end
  end
  describe 'cancel' do
    it 'should destroy selected appointment' do
      tomorrow=DateTime.now+1
      new_appointment=Appointment.new
      new_appointment.medic = 'Hector Medina'
      new_appointment.date_and_hour = DateTime.new(tomorrow.year,tomorrow.month,tomorrow.day,19,0,0,0)
      new_appointment.duration = 30
      new_appointment.patient_name = "patient_email@email.com"
      new_appointment.id = 1
      new_appointment.should_receive(:destroy).and_return(true)
      new_appointment.cancel
    end
  end
end
