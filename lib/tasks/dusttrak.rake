namespace :dusttrak do
  desc "Crea Mediciones basadas en los Historical y Aparatos existentes"
  task :mediciones_previas => :environment do
    Historical.find_each do |h|
      Aparato.find_by_grd(h.grd_id) do |aparato|
        aparato.mediciones.create(
          concentracion: h.concentracion(aparato.cero, aparato.escala),
          created_at: h.timestamp,
          grd_id: h.grd_id,
          valor: h.value
        )
      end
    end
  end

  desc "Instala el trigger para que los nuevos historical creen mediciones"
  task :instalar_trigger => :environment do
    require 'io/console'

    spec = ActiveRecord::Base.connection_config

    logger.info "La instalación del trigger necesita permisos de superusuario para la base de datos"
    logger.info "Pasalos como parámetros (usuario y password) o respondé cuando te pida"

    spec[:username] = if ENV['usuario'].present?
      ENV['usuario']
    else
      logger.info "Superusuario de la base de datos:"
      STDIN.noecho(&:gets).chomp
    end

    spec[:password] = if ENV['password'].present?
      ENV['password']
    else
      logger.info "Password del superusuario:"
      STDIN.noecho(&:gets).chomp
    end

    pool = ActiveRecord::Base.establish_connection(spec)

    pool.connection.execute('drop trigger insert_concentracion;')
    pool.connection.execute('
      create trigger insert_concentracion before insert on historical
      for each row
      begin
        insert into mediciones (created_at, grd_id, concentracion, valor)
        select NEW.timestamp, NEW.grd_id, (NEW.value - aparatos.cero) / aparatos.escala / 1000, NEW.value
        from aparatos where NEW.grd_id = grd;
      end'
    )
  end
end
