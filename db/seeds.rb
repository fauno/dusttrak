# Umbral de error default
Configuracion.create unless Configuracion.any?

if ENV['password'].present?
  Usuario.create(nombre: 'admin', password: ENV['password'])
else
  logger.info 'Si querías crear un admin probá de nuevo con: `rake db:seed password="el password del admin global"`'
end

# Aparatos de acuerdo a los historical existentes. Les creamos una
# configuración inicial con valores por default y que abarque los históricos má
# viejos
Historical.pluck(:grd_id).uniq.each do |grd|
  unless Aparato.find_by_grd(grd).present?
    Aparato.create(grd: grd, nombre: "id: #{grd}")
  end
end
