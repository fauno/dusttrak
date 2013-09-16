class Medicion < ActiveRecord::Base
  belongs_to :aparato, inverse_of: :mediciones,
    primary_key: :grd, foreign_key: :grd_id

  delegate :cero, :escala, to: :aparato, allow_nil: true

  default_scope order('created_at desc')

  # TODO refactorizarlo con NullObject
  def aparato
    super || Aparato.new
  end

  # Inspirado en:
  # http://stackoverflow.com/questions/2793994/group-mysql-query-by-15-min-intervals
  #
  # Se puede usar así:
  #
  #   Medicion.promediar_cada 15.minutes
  def self.promediar_cada(segundos)
    select("grd_id, created_at, avg(concentracion) as concentracion,
      round(unix_timestamp(created_at)/#{segundos}) as rango"
    ).group(:grd_id, :rango)
  end

  def self.desde(timestamp)
    where "`created_at` > ?",
      DateTime.parse(timestamp).strftime("%Y-%m-%d 00:00:00")
  end

  def self.hasta(timestamp)
    where "`created_at` < ?",
      DateTime.parse(timestamp).strftime("%Y-%m-%d 23:59:59")
  end

  def self.sobre_umbral
    where('concentracion > ?', Configuracion.umbral)
  end

  def sobre_umbral?
    self.concentracion > Configuracion.umbral
  end

  def error?
    self.concentracion < 0
  end

  def fecha(offset = 0)
    (self.created_at + offset).strftime("%d/%m/%Y %T")
  end
end
