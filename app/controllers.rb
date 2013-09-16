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

end
