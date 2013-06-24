Rene::App.controllers :appointments do

  get :new do
		@rol = 'Turno Asignado'      
		render 'appointments/new'
   end

	get :new_pending_appointment do
		@rol = 'Turno Pendiente'
		render 'appointments/new'
	end

   get :show do
			@rol = "Turno Asignado"      
			@appointment = Appointment.get(session[:id])
      render 'appointments/show'
   end

	 get :show_pending_appointment do
			@rol = "Turno Pendiente"       
			@appointment = Appointment.get(session[:id])
      render 'appointments/show'
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
		validation = validation_pending_appointment(params[:hour], params[:date], params[:medic],params[:duration]) 
		if validation		
			@appointment = appointment_new_instance(params[:hour], params[:date], params[:medic],params[:duration],"",current_account.friendly_name)
		  appointment_new_save(@appointment,'_pending_appointment')
		else
       flash[:error] = validation_error_pending_appointment(params[:hour], params[:date], params[:medic],params[:duration])
       redirect 'appointments/new_pending_appointment'
    end

   end

	post :create do
		validation = validation(params[:hour], params[:date], params[:medic],params[:duration],params[:patient_name])  
		if validation		
			@appointment = appointment_new_instance(params[:hour], params[:date], params[:medic],params[:duration],params[:patient_name],current_account.friendly_name)
		  appointment_new_save(@appointment,'')
		else
       flash[:error] = validation_error(params[:hour], params[:date], params[:medic],params[:duration],params[:patient_name])
       redirect 'appointments/new'
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
