# Definición en la BD (comentado acá porque está ignorado en el esquema)
#   primary_key "historial_id"
#   integer     "grd_id",         :null => false
#   integer     "register_type",  :null => false
#   datetime    "timestamp",      :null => false
#   integer     "address",        :null => false
#   integer     "value",          :null => false
#   integer     "historical_type"
#   timestamp   "insertion_time", :null => false
class Historical < ActiveRecord::Base
  self.table_name = 'historical'

  belongs_to :aparato, inverse_of: :mediciones,
    primary_key: :grd, foreign_key: :grd_id

  after_initialize :readonly!

  delegate :cero, :escala, to: :aparato, allow_nil: true

  # TODO refactorizarlo con NullObject
  def aparato
    super || Aparato.new
  end

  # Generar una consulta como mas_concentracion pero para agrupar y
  # promediar
  def self.mas_concentracion_promedio
    select("count(*) as 'grd_id',
            group_concat(zero) as 'zero',
            group_concat(scale) as 'scale',
            `timestamp`,
            group_concat(value) as 'value',
            round(avg(((value - zero) / scale) / 1000), 3) as 'concentracion'")
  end

  # http://forums.mysql.com/read.php?10,174757,176666#msg-176666
  # Dividimos los minutos de cada hora por el valor de agrupación para
  # poder parametrizarlo.  Se asume que la multiplicación por tres lleva
  # esta relación con la respuesta original (cada 20 minutos).
  def self.cada(x)
    group("(60/#{x}) * hour(`timestamp`) + floor(minute(`timestamp`) / #{x})")
  end

  def self.desde(timestamp)
    where "`timestamp` > ?",
      DateTime.parse(timestamp).strftime("%Y-%m-%d 00:00:00")
  end

  def self.hasta(timestamp)
    where "`timestamp` < ?",
      DateTime.parse(timestamp).strftime("%Y-%m-%d 23:59:59")
  end

  def concentracion
    (((self.value - self.cero) / self.escala) / 1000).round(3)
  end

  def sobre_umbral?
    self.concentracion > Configuracion.umbral
  end

  def error?
    self.value < self.cero
  end
end
