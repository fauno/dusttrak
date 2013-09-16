class CreateConfiguraciones < ActiveRecord::Migration
  def up
    create_table :configuraciones do |t|
      t.string  :atributo
      t.string  :valor
    end
  end

  def down
    drop_table :configuraciones
  end
end
