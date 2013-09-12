class DropParametros < ActiveRecord::Migration

  # Los modelos acá hacen a la migración a prueba de cambios en los modelos
  class Aparato < ActiveRecord::Base
    has_many :parametros, dependent: :destroy
  end

  class Parametro < ActiveRecord::Base
    belongs_to :aparato
  end

  def up
    Aparato.all.each do |a|
      p = a.parametros.order('created_at desc').first
      if p.present?
        a.update_attribute(:cero, p.cero)
        a.update_attribute(:escala, p.escala)
      end
    end
    drop_table :parametros
  end

  def down
    create_table "parametros", :force => true do |t|
      t.integer  "aparato_id"
      t.float    "escala",     :default => 3.2
      t.integer  "cero",       :default => 3996
      t.datetime "created_at",                   :null => false
      t.datetime "updated_at",                   :null => false
    end
  end
end
