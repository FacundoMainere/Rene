require 'spec_helper'
require 'date'

describe Appointment do

  describe 'add_new_appointment' do
    it "should create a new instance of an appointment with the right medic name" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now.tomorrow,19,0,20)
      new_appointment.medic.should eq 'RobertoBolanios'
    end
    it "should create a new instance of an appointment with the right date" do
      entered_date_and_time = DateTime.now.tomorrow.change({:hour => 19, :min => 0, :sec => 0})
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now.tomorrow,19,0,20)
      new_appointment.dateAndHour.should eq entered_date_and_time
    end
    it "should create a new instance of an appointment with the right duration" do
      new_appointment=Appointment.add_new_appointment('Roberto Bolanios',DateTime.now.tomorrow,19,0,20)
      new_appointment.medic.should eq 20
    end
  end
end
