require 'spec_helper'

describe Account do

  describe 'list_upcoming_turns' do
    it 'should return a list with a single element when only one appointment validates the condition' do
      appointment1 = Appointment.new
      appointment2 = Appointment.new

      account = Account.new
      account.uid = "user_friendly_name@email.com"
      Appointment.should_receive(:all).with(:user_friendly_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2])
      Appointment.should_receive(:all).with(:date_and_hour.gte => anything(),:order => [:date_and_hour.asc]).and_return([appointment1])

      result_appointment = account.medic_list_upcoming_appointments()
      result_appointment.size().should == 1
    end
   it 'should return an empty list when no appointments validates the condition' do
      appointment1 = Appointment.new
      appointment2 = Appointment.new
      account = Account.new
      account.uid = "user_friendly_name@email.com"
      Appointment.should_receive(:all).with(:user_friendly_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2])
      Appointment.should_receive(:all).with(:date_and_hour.gte => anything(),:order => [:date_and_hour.asc]).and_return([])
      account.medic_list_upcoming_appointments().should eq []
    end
  end
  
  describe 'patient_list_upcoming_turns' do
    it 'should return a list with a single element when only one appointment validates the condition' do
      appointment1 = Appointment.new
      appointment2 = Appointment.new

      account = Account.new
      account.uid = "user_friendly_name@email.com"
      Appointment.should_receive(:all).with(:patient_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2])
      Appointment.should_receive(:all).with(:date_and_hour.gte => anything(),:order => [:date_and_hour.asc]).and_return([appointment1])

      result_appointment = account.patient_list_upcoming_appointments()
      result_appointment.size().should == 1
    end
   it 'should return an empty list when no appointments validates the condition' do
      appointment1 = Appointment.new
      appointment2 = Appointment.new
      account = Account.new
      account.uid = "user_friendly_name@email.com"
      Appointment.should_receive(:all).with(:patient_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2])
      Appointment.should_receive(:all).with(:date_and_hour.gte => anything(),:order => [:date_and_hour.asc]).and_return([])
      account.patient_list_upcoming_appointments().should eq []
    end
  end
end
