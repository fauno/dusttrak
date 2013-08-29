class Configuracion < ActiveRecord::Base
  validates_uniqueness_of :atributo

  # Rango de tiempo en minutos según el que agrupar
  def self.grouped
    where(atributo: 'grouped').first.valor.to_f
  end

  # Valor de E
  def self.escala
    where(atributo: 'escala').first.valor.to_f
  end

  # Corriente en µA (I)
  def self.corriente
    where(atributo: 'corriente').first.valor
  end
end
