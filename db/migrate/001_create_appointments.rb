migration 1, :create_appointments do
  up do
    create_table :appointments do
      column :id, Integer, :serial => true
      column :medic, String, :length => 255
      column :date_and_hour, DateTime
      column :duration, Integer
    end
  end

  down do
    drop_table :appointments
  end
end
