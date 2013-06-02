Rene::App.controllers :appointment do
   
   get :new do
      render 'appointment/new'
   end

   get :show do
      render 'appointments/show'
   end

   post :create do
      @appoint = Appointment.new(params[:appoint])
      if @appoint.save
         redirect(url(:events, :show, :id => @appoint.id))
      else
         flash.now[:error] = "Error: ambos campos son requeridos"
         render 'events/new'
    end
   end

end
