class RedefinirConfiguracion < ActiveRecord::Migration
  def self.up
    create_table :configuraciones, force: true do |t|
      t.float   :umbral, default: 0.3

      t.timestamps
    end
  end

  def self.down
    create_table "configuraciones", force: true do |t|
      t.string "atributo"
      t.string "valor"
    end
  end
end
