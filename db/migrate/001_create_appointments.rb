migration 1, :create_appointments do
  up do
    create_table :appointments do
      column :id, Integer, :serial => true
      column :medic, String, :length => 255
      column :dateAndHour, DateTime
      column :duration, Integer
    end
  end

  down do
    drop_table :appointments
  end
end
