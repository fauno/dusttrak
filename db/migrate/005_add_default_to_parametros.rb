class AddDefaultToParametros < ActiveRecord::Migration
  def self.up
    change_column_default :parametros, :escala, 3.2
    change_column_default :parametros, :cero, 3996
  end

  def self.down
    change_column_default :parametros, :escala, nil
    change_column_default :parametros, :cero, nil
  end
end
