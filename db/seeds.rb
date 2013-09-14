# Umbral de error default
Configuracion.create unless Configuracion.any?

if ENV['password'].present?
  Usuario.create(nombre: 'admin', password: ENV['password'])
else
  logger.info 'Si querías crear un admin probá de nuevo con:

             rake db:seed password="el password del admin global"'
end

# Aparatos de acuerdo a los historical existentes. Se crean con cero y escala
# por default. Hay que modificarlos y correr
#
#     rake dusttrak:mediciones_previas
#
# para que se creen las mediciones con los cero y escala correctos
Historical.pluck(:grd_id).uniq.each do |grd|
  Aparato.find_or_create_by_grd(grd) do |aparato|
    aparato.nombre = "id: #{grd}"
  end
end

logger.info "Después de configurar cada aparato, corré

             rake dusttrak:mediciones_previas"
