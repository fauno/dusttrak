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
end
