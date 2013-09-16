class CreateAparatos < ActiveRecord::Migration
  def self.up
    create_table :aparatos do |t|
      t.string :nombre
      t.text :observaciones
      t.integer :grd
      t.timestamps
    end
  end

  def self.down
    drop_table :aparatos
  end
end
