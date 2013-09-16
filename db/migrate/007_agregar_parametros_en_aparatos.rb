class AgregarParametrosEnAparatos < ActiveRecord::Migration
  def change
    add_column :aparatos, :escala, :float, default: 3.2
    add_column :aparatos, :cero, :integer, default: 3996
  end
end
