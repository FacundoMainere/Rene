Rene::App.controllers :appointments do

   get :new do
      render 'appointments/new'
   end

   get :show do
      @appointment = Appointment.get(params[:id].to_i)
      render 'appointments/show'
   end

   post :create do
      medic_name = params[:medic]
      date = params[:date]
      hour_and_minutes = params[:hour]
      duration = params[:duration]

      if valid_hour?(hour_and_minutes) && valid_date?(date) && valid_medic_name?(medic_name) && ! one_is_empty?(hour_and_minutes, date, medic_name, duration)
         hour = render_hour(hour_and_minutes)
         minutes = render_minutes(hour_and_minutes)
         @appointment = Appointment.add_new_appointment(medic_name, render_date(date), hour, minutes, duration)

         if @appointment.save
            redirect(url(:appointments, :show, :id => @appointment.id))
         else
            if not @appointment.check_date
               flash.now[:error] = "Error: Fecha/hora invalida. Ingrese una fecha/hora posterior."
            elsif not @appointment.check_turn_is_taken
               flash.now[:error] = "Error: Turno ya registrado. Ingrese un nuevo turno."
            else
               flash.now[:error] = "Error: Todos los campos son requeridos."
            end
            render 'appointments/new'
         end
      else
         flash.now[:error] = validation_error(hour_and_minutes, date, medic_name, duration)
         render 'appointments/new'
      end

   end

end
