require 'spec_helper'

describe Account do

#  describe 'list_upcoming_turns' do
#it 'should return a list with a single element when only one appointment validates the condition' do
#      appointment1 = Appointment.new
#      appointment2 = Appointment.new

#      account = Account.new
#      account.uid = "user_friendly_name@email.com"
#      Appointment.should_receive(:all).with(:user_friendly_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2]) 
#      Appointment.should_receive(:all).with(:date_and_hour.gte => DateTime.now).and_return([appointment1])     
      
#      result_appointment = account.list_upcoming_turns()
#      result_appointment.size().should == 1
#    end

#   it 'should return an empty list when no appointments validates the condition' do
#      appointment1 = Appointment.new
#      appointment2 = Appointment.new

#      account = Account.new
#      account.uid = "user_friendly_name@email.com"
#      Appointment.should_receive(:all).with(:user_friendly_name => 'user_friendly_name@email.com').and_return([appointment1, appointment2]) 
#      Appointment.should_receive(:all).with(:date_and_hour.lte => DateTime.now).and_return([])     

#      account.list_upcoming_turns().should eq nil
#    end
#  end
end
