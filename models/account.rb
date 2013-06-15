class Account
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :email, String
  property :uid, String
  property :provider, String

  def friendly_name
     name.nil? ? uid : name
  end

  def self.create_with_omniauth(auth)
     account = Account.new
     account.provider = auth["provider"]
     account.uid      = auth["uid"]
     account.name     = auth["info"]["nickname"] # warn: this is for twitter
     account.save
     account
  end

  def list_upcoming_appointments_as(a_role_identifying_symbol)
      appointments = Appointment.all(a_role_identifying_symbol => self.friendly_name) &
      Appointment.all(:date_and_hour.gte => DateTime.now, :order => [:date_and_hour.asc])
  end
  
  def medic_list_upcoming_appointments
    list_upcoming_appointments_as :user_friendly_name
  end

  def patient_list_upcoming_appointments
    list_upcoming_appointments_as :patient_name
  end

end
