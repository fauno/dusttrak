class DropUsuarios < ActiveRecord::Migration
  def self.up
    drop_table :usuarios
  end

  def self.down
    create_table :usuarios do |t|
      t.string :nombre
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
