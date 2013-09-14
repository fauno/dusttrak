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
    # Llamamos .all después de aplicar los filtros para que devuelva un array
    # que paginar (will_paginate rompe la agrupación)
    render_all filtrar(Medicion.promediar_cada(rango)).all
  end

  get :above do
    render_all filtrar(Medicion.sobre_umbral)
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
