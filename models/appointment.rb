class Appointment
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :medic, String
  property :dateAndHour, DateTime
  property :duration, Integer
end
