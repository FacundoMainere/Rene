Rene::App.controllers :appointments do

   get :new do
      render 'appointments/new'
   end

   get :show do
      @appointment = Appointment.get(params[:id].to_i)
      render 'appointments/show'
   end

	 get :show_pending_appointment do
      @appointment = Appointment.get(params[:id].to_i)
      render 'appointments/show_pending_appointment'
   end

   get :medical_office_list do
      render_list("Consultorio")
   end

 	get :patient_list do
	  	render_list("Paciente")
	end
		
	get :select_office do
		render 'appointments/select_office'
	end

	get :book_appointment_list do	
		@rol = "Paciente Reserva" 
	 	@appointments = Appointment.patient_booker_list_upcoming_appointments(params[:office])
    render 'appointments/list'
	end

	get :new_pending_appointment do
		render 'appointments/new_pending_appointment'
	end

	post :book_appointment do
		  appointments = params[:appointments_id]
      if appointments.nil?
         flash.now[:error] = "Error: Debe seleccionar al menos un turno."
      else
         appointments.each do |appID|
            appointment=Appointment.get(appID)
            if !appointment.nil? then appointment.assign_patient(current_account.friendly_name)		
						end
         end
      end
      render 'appointments/show_book_appointment_message'  
   end

	post :create_pending_appointment do
    medic_name = params[:medic]
    date = params[:date]
    hour_and_minutes = params[:hour]
    duration = params[:duration]

    if validation_pending_appointment(hour_and_minutes, date, medic_name, duration)
       hour = render_hour(hour_and_minutes)
       minutes = render_minutes(hour_and_minutes)
       @appointment = Appointment.add_new_appointment(medic_name, render_date(date), hour, 
                                                      minutes, duration, "" , current_account.friendly_name)

       if @appointment.save
          redirect(url(:appointments, :show_pending_appointment, :id => @appointment.id))
       else
          if not @appointment.check_date
             flash.now[:error] = "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."
          elsif not @appointment.check_turn_is_taken
             flash.now[:error] = "Error: Turno ya registrado. Ingrese un nuevo turno."
          elsif not @appointment.check_patient_is_available
             flash.now[:error] = "Error: Este paciente ya tiene un turno en ese horario."
          end
          render 'appointments/new_pending_appointment'
       end
    else
       flash.now[:error] = validation_error_pending_appointment(hour_and_minutes, date, medic_name, duration)
       render 'appointments/new_pending_appointment'
    end

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
            end
            render 'appointments/new'
         end
      else
         flash.now[:error] = validation_error(hour_and_minutes, date, medic_name, duration, patient_name)
         render 'appointments/new'
      end

   end
   
   post :delete do
      appointments = params[:appointments_id]
      puts appointments
      if appointments.nil?
         flash.now[:error] = "Error: Debe seleccionar al menos un turno."
      else
         appointments.each do |appID|
            appointment=Appointment.get(appID)
            if !appointment.nil? then appointment.cancel end
         end
      end
      render_list(params[:rol])
   end
end
