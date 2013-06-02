class Appointment
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :medic, String
  property :dateAndHour, DateTime
  property :duration, Integer
  attr_accessor :medic, :dateAndHour, :duration

  def Appointment.add_new_appointment(medic_name,date,hour,minutes,duration)
    new_appointment=self.new
    new_appointment.medic=medic_name
    new_appointment.dateAndHour=DateTime.new(date.year,date.month,date.day,hour,minutes,0,0)
    new_appointment.duration=duration
    new_appointment
  end
end
