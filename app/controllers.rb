Dusttrak::App.controllers  do
  get :index do
    render 'index/index'
  end

  get :all do
    @historical = filtrar(Historical.mas_concentracion)

    render 'historical/all'
  end

  # Agrupar cada 15 minutos
  get :grouped do
    @historical = filtrar(Historical.mas_concentracion.cada(Configuracion.grouped))

    render 'historical/all'
  end

  get :threshold do
  end

  get :below do
  end

end

def filtrar(historical)
  historical = historical.desde(params[:desde]) if params[:desde].present?
  historical = historical.hasta(params[:hasta]) if params[:hasta].present?
  historical
end
