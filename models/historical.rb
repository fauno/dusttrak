# Mantenemos este modelo como helper para la migración inicial de Historical a
# Medicion
#
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

  after_initialize :readonly!

  def concentracion(cero, escala)
    (((self.value - cero) / escala) / 1000)
  end
end
