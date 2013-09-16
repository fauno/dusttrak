# encoding: utf-8
class Configuracion < ActiveRecord::Base
  # Devuelve la última configuración creada
  def self.actual
    order('created_at desc').limit(1)
  end

  def self.umbral
    actual.first.umbral
  end
end
