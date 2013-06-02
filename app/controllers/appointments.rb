Rene::App.controllers :appointments do
   
   get :new do
      render 'appointments/new'
   end

   get :show do
      @appointment = Appointment.get(params[:id].to_i)
      render 'appointments/show'
   end

   post :create do
      hour = render_hour(params[:hour])
      minutes = render_minutes(params[:hour])
      @appointment = Appointment.add_new_appointment(params[:medic], render_date(params[:date]), hour, minutes, params[:duration])
      if @appointment.save
         redirect(url(:appointments, :show, :id => @appointment.id))
      else
         flash.now[:error] = "Error: Turno ya registrado. Ingrese un nuevo turno."
         render 'appointments/new'
    end
   end

end
