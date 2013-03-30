class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :usuario
      t.belongs_to :producto
      t.belongs_to :pedido
      t.integer :cantidad
      t.integer :precio
      t.string :guest_token

      t.timestamps
    end
    add_index :items, :usuario_id
    add_index :items, :producto_id
    add_index :items, :pedido_id
    add_index :items, :guest_token
  end
end
