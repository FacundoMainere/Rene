require 'active_support/all'
class Appointment
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :medic, String, :required => true
  property :date_and_hour, DateTime, :required => true
  property :duration, Integer, :required => true
  property :patient_name, String
  property :user_friendly_name, String, :required => true

  validates_with_method :check_date, :check_turn_is_taken, :check_patient_is_available

  def check_date
    return (self.date_and_hour >= DateTime.now) if self.date_and_hour.is_a?(DateTime)
  end

	def self.patient_booker_list_upcoming_appointments(consultorio)
		appointments = Appointment.all(:patient_name => "", :user_friendly_name => consultorio) &
    Appointment.all(:date_and_hour.gte => DateTime.now, :order => [:date_and_hour.asc])
  end

  def capitalize_name(name)
    splitted=name.split(' ')
    resultingName=''
    splitted.each{|name| resultingName=resultingName+(name.capitalize)+' '}
    resultingName[0..-2]
  end

  def check_turn_is_taken
    turns_by_a_doctor=Appointment.all(:medic => self.medic, :user_friendly_name => self.user_friendly_name)
    turns_by_a_doctor.select{|appointment| self.overlaps(appointment)}.empty?
  end

  def check_patient_is_available
    turns_by_a_doctor=Appointment.all(:patient_name => self.patient_name)
    turns_by_a_doctor.select{|appointment| self.overlaps(appointment)}.empty?
  end

  def overlaps(other_appointment)
    first_app_range=self.date_and_hour..self.date_and_hour+self.duration.minutes
    second_app_range=other_appointment.date_and_hour..other_appointment.date_and_hour+other_appointment.duration.minutes
    (first_app_range.first <= second_app_range.last) and (second_app_range.first <= first_app_range.last)
  end

  def cancel
    self.destroy
  end

	def assign_patient(name)
	  new_appointment = Appointment.add_new_appointment(self.medic, self.date_and_hour, self.date_and_hour.hour, self.date_and_hour.to_s[14..15].to_i, self.duration, name, self.user_friendly_name)
	  self.cancel
     new_appointment.save
	end

  def Appointment.add_new_appointment(medic_name, date, hour, minutes, duration=15, patient_name, user_friendly_name)
    new_appointment = self.new
    new_appointment.medic = new_appointment.capitalize_name(medic_name)
    new_appointment.date_and_hour = DateTime.new(date.year, date.month, date.day, hour, minutes, 0, 0)
    new_appointment.duration = duration
    new_appointment.patient_name = patient_name
    new_appointment.user_friendly_name = user_friendly_name
    new_appointment
  end
end
