# Helper methods defined here can be accessed in any controller or view in the application
Dusttrak::App.helpers do

  # Filtra los históricos de acuerdo a los parámetros de la vista.
  def filtrar(historical)
    historical = historical.where(grd_id: params[:grd_id]) if params[:grd_id].present?
    historical = historical.desde(params[:desde]) if params[:desde].present?
    historical = historical.hasta(params[:hasta]) if params[:hasta].present?
    historical
  end

  def fecha_mas_vieja
    Medicion.last.created_at.strftime("%d-%m-%Y")
  end

  def fecha_mas_nueva
    Medicion.first.created_at.strftime("%d-%m-%Y")
  end

  def rango
    params[:rango].present? ? params[:rango].to_i : Dusttrak::App.rango
  end

  def mostrar_rango?
    @rango
  end

  def render_all(historical)
    if not historical.any?
      halt 404, haml(:none)
    end

    if params[:xls].present?
      file = write_xls(historical)

      if file.present?
        send_file file, type: 'application/vnd.ms-excel', filename: File.basename(file)
      end
    else
      @historical = historical.paginate(page: params[:page])
      @aparatos = Aparato.all

      render 'historical/all', :locals => {
        :bootstrap => BootstrapPagination::Sinatra
      }
    end
  end

  # Escribe una planilla y devuelve el nombre de archivo
  def write_xls(historical)

    # TODO mover a filtro_to_s o algo asi para usar en todos lados
    name = "Dusttrak"
    name << " #{params[:grd_id]}" if params[:grd_id].present?
    name << " #{DateTime.parse(params[:desde]).strftime("%Y-%m-%d 00:00:00")}" if params[:desde].present?
    name << " - #{DateTime.parse(params[:hasta]).strftime("%Y-%m-%d 23:59:59")}" if params[:hasta].present?

    file = "public/files/#{Time.now} - #{name}.xls"

    # Generar la "vista"
    h = []
    historical.each do |i|
      r = {}
      r["Id"] = i.grd_id

      if mostrar_rango?
        r["Rango del Promedio"] = "#{i.fecha} - #{i.fecha(rango)}"
      else
        r["Fecha"] = i.created_at
        r["Valor"] = i.valor
      end

      r["Concentracion"] = i.concentracion

      h.push (r)
    end

    begin
      archive = WriteExcel.new(file)
      sheet   = archive.add_worksheet

      sheet.write(0, 0, "Siafa")
      sheet.write(1, 0, "Dusttrak")

      sheet.write(3, 0, "Filtro: #{name}")

      header = h[0].keys
      sheet.write(4, 0, header)

      matriz = h.collect { |row| row.values }
      sheet.write(5, 0, matriz.transpose)

      archive.close
    rescue
      return nil
    end

    # Devolver el nombre de archivo
    file

  end
end
