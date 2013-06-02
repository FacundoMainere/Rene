require 'active_support/all'
class Appointment
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :medic, String, :required => true
  property :date_and_hour, DateTime, :required => true
  property :duration, Integer, :required => true
  attr_accessor :medic, :date_and_hour, :duration

  validates_with_method :check_date

  def check_date
    return (self.date_and_hour >= DateTime.now) if self.date_and_hour.is_a?(DateTime)
    return false
  end

  def capitalize_name(name)
    splitted=name.split(' ')
    resultingName=''
    splitted.each{|name| resultingName=resultingName+(name.capitalize)+' '}
    resultingName[0..-2]
  end

  def check_turn_is_taken
    turns_by_a_doctor=Appointment.all(:medic=>self.medic)
    not turns_by_a_doctor.select{|appointment| self.overlaps(appointment)}.empty?
  end

  def overlaps(other_appointment)
    first_app_range=self.date_and_hour..self.date_and_hour+self.duration.minutes
    second_app_range=other_appointment.date_and_hour..other_appointment.date_and_hour+other_appointment.duration.minutes
    (first_app_range.first <= second_app_range.last) and (second_app_range.first <= first_app_range.last)
  end

  def Appointment.add_new_appointment(medic_name,date,hour,minutes,duration)
    new_appointment = self.new
    new_appointment.medic = new_appointment.capitalize_name(medic_name)
    new_appointment.date_and_hour = DateTime.new(date.year,date.month,date.day,hour,minutes,0,0)
    new_appointment.duration = duration
    new_appointment
  end
end
