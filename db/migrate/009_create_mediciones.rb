class CreateMediciones < ActiveRecord::Migration
  def up
    create_table :mediciones do |t|
      t.integer :grd_id, null: false
      t.float :concentracion, null: false
      t.integer :valor, null: false
      t.datetime :created_at, null: false
    end
  end

  def down
    drop_table :mediciones
  end
end
