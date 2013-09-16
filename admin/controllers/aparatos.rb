Dusttrak::Admin.controllers :aparatos do
  get :index do
    @title = "Aparatos"
    @aparatos = Aparato.all
    render 'aparatos/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'aparato')
    @aparato = Aparato.new
    render 'aparatos/new'
  end

  post :create do
    @aparato = Aparato.new(params[:aparato])
    if @aparato.save
      @title = pat(:create_title, :model => "aparato #{@aparato.id}")
      flash[:success] = pat(:create_success, :model => 'Aparato')
      params[:save_and_continue] ? redirect(url(:aparatos, :index)) : redirect(url(:aparatos, :edit, :id => @aparato.id))
    else
      @title = pat(:create_title, :model => 'aparato')
      flash.now[:error] = pat(:create_error, :model => 'aparato')
      render 'aparatos/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "aparato #{params[:id]}")
    @aparato = Aparato.find(params[:id])
    if @aparato
      render 'aparatos/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'aparato', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "aparato #{params[:id]}")
    @aparato = Aparato.find(params[:id])
    if @aparato
      if @aparato.update_attributes(params[:aparato])
        flash[:success] = pat(:update_success, :model => 'Aparato', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:aparatos, :index)) :
          redirect(url(:aparatos, :edit, :id => @aparato.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'aparato')
        render 'aparatos/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'aparato', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Aparatos"
    aparato = Aparato.find(params[:id])
    if aparato
      if aparato.destroy
        flash[:success] = pat(:delete_success, :model => 'Aparato', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'aparato')
      end
      redirect url(:aparatos, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'aparato', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Aparatos"
    unless params[:aparato_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'aparato')
      redirect(url(:aparatos, :index))
    end
    ids = params[:aparato_ids].split(',').map(&:strip)
    aparatos = Aparato.find(ids)
    
    if Aparato.destroy aparatos
    
      flash[:success] = pat(:destroy_many_success, :model => 'Aparatos', :ids => "#{ids.to_sentence}")
    end
    redirect url(:aparatos, :index)
  end
end
