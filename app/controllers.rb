Dusttrak::App.controllers  do

  get :index do
    render 'index/index'
  end

  get :all do
    render_all filtrar(Medicion)
  end

  # Agrupar cada 15 minutos
  get :grouped do
    @rango = true
    render_all filtrar(Medicion.mas_concentracion_promedio.cada(rango))
  end

  get :above do
    render_all filtrar(Medicion).select(&:sobre_umbral?)
  end

  # TODO poner esto en el controlador admin y lo de historical en el suyo
  get :admin do
    halt(401, 'No estás autorizado') unless authenticate_or_request_with_http_basic
    @aparatos = Aparato.all
    render 'admin/index'
  end

  post :admin do
    halt(401, 'No estás autorizado') unless authenticate_or_request_with_http_basic
    # TODO mostrar mensajes de error/éxito
    AdminForm.new(params).save
    @aparatos = Aparato.all
    render 'admin/index'
  end
end
