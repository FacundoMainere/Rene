require 'spec_helper'
require 'date'

describe Appointment do

  describe 'add_new_appointment' do
    it "should create a new instance of an appointment with the right medic name" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20)
      new_appointment.medic.should eq 'Roberto Bolanios'
    end
    it "should create a new instance of an appointment with the right date" do
      now=DateTime.now
      entered_date_and_time=DateTime.new(now.year,now.month,now.day+1,19,0,0,0)
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20)
      new_appointment.dateAndHour.should eq entered_date_and_time
    end
    it "should create a new instance of an appointment with the right duration" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now+1,19,0,20)
      new_appointment.duration.should eq 20
    end
  end
end
