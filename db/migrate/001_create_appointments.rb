migration 1, :create_appointments do
  up do
    create_table :appointments do
      column :id, Integer, :serial => true
      column :medic, String, :length => 255
      column :date_and_hour, DateTime
      column :duration, Integer
      column :patient_email, String, :length => 255
      column :user_friendly_name, String, :length => 255
    end
  end

  down do
    drop_table :appointments
  end
end
