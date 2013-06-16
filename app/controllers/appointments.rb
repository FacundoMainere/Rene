Rene::App.controllers :appointments do

   get :new do
      render 'appointments/new'
   end

   get :show do
      @appointment = Appointment.get(params[:id].to_i)
      render 'appointments/show'
   end

   get :medical_office_list do
      @rol = "Consultorio"
      @appointments = current_account.medic_list_upcoming_appointments
      @message = "No hay turnos proximos."
      @appointments_id = Array.new
      render 'appointments/list'
   end

   get :patient_list do
      @rol = "Paciente"
      @appointments = current_account.patient_list_upcoming_appointments
      @message = "No hay turnos proximos."
      render 'appointments/list'
   end

   post :create do
      medic_name = params[:medic]
      date = params[:date]
      hour_and_minutes = params[:hour]
      duration = params[:duration]
      patient_name = params[:patient_name]

      if validation(hour_and_minutes, date, medic_name, duration, patient_name)
         hour = render_hour(hour_and_minutes)
         minutes = render_minutes(hour_and_minutes)
         @appointment = Appointment.add_new_appointment(medic_name, render_date(date), hour, 
                                                        minutes, duration, patient_name, current_account.friendly_name)

         if @appointment.save
            redirect(url(:appointments, :show, :id => @appointment.id))
         else
            if not @appointment.check_date
               flash.now[:error] = "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."
            elsif not @appointment.check_turn_is_taken
               flash.now[:error] = "Error: Turno ya registrado. Ingrese un nuevo turno."
            elsif not @appointment.check_patient_is_available
               flash.now[:error] = "Error: Este paciente ya tiene un turno en ese horario."
            else
               flash.now[:error] = "Error: Todos los campos son requeridos."
            end
            render 'appointments/new'
         end
      else
         flash.now[:error] = validation_error(hour_and_minutes, date, medic_name, duration, patient_name)
         render 'appointments/new'
      end

   end
   
   get :delete do
      appointment = Appointment.find_by_id(params[:appointments_id])
      appointment.destroy
     # if ! Appointment.delete_appointment(params[:appointments_id])
     #    flash.now[:error] = "Error: Debe seleccionar un turno"
     # end
      redirect params[:redirect_page]
   end
end
