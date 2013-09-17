Dusttrak::Admin.controllers :configuraciones do
  get :index do
    @title = "Configuraciones"
    @configuraciones = Configuracion.all
    render 'configuraciones/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'configuracion')
    @configuracion = Configuracion.new
    render 'configuraciones/new'
  end

  post :create do
    @configuracion = Configuracion.new(params[:configuracion])
    if @configuracion.save
      @title = pat(:create_title, :model => "configuracion #{@configuracion.id}")
      flash[:success] = pat(:create_success, :model => 'Configuracion')
      params[:save_and_continue] ? redirect(url(:configuraciones, :index)) : redirect(url(:configuraciones, :edit, :id => @configuracion.id))
    else
      @title = pat(:create_title, :model => 'configuracion')
      flash.now[:error] = pat(:create_error, :model => 'configuracion')
      render 'configuraciones/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "configuracion #{params[:id]}")
    @configuracion = Configuracion.find(params[:id])
    if @configuracion
      render 'configuraciones/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'configuracion', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "configuracion #{params[:id]}")
    @configuracion = Configuracion.find(params[:id])
    if @configuracion
      if @configuracion.update_attributes(params[:configuracion])
        flash[:success] = pat(:update_success, :model => 'Configuracion', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:configuraciones, :index)) :
          redirect(url(:configuraciones, :edit, :id => @configuracion.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'configuracion')
        render 'configuraciones/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'configuracion', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Configuraciones"
    configuracion = Configuracion.find(params[:id])
    if configuracion
      if configuracion.destroy
        flash[:success] = pat(:delete_success, :model => 'Configuracion', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'configuracion')
      end
      redirect url(:configuraciones, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'configuracion', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Configuraciones"
    unless params[:configuracion_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'configuracion')
      redirect(url(:configuraciones, :index))
    end
    ids = params[:configuracion_ids].split(',').map(&:strip)
    configuraciones = Configuracion.find(ids)
    
    if Configuracion.destroy configuraciones
    
      flash[:success] = pat(:destroy_many_success, :model => 'Configuraciones', :ids => "#{ids.to_sentence}")
    end
    redirect url(:configuraciones, :index)
  end
end
