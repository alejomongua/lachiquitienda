class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.string :guia
      t.integer :costo_envio
      t.string :tipo_envio
      t.string :direccion_envio
      t.string :ciudad_envio
      t.string :destinatario
      t.string :telefono, limit: 20
      t.string :numero_consignacion
      t.date :fecha_consignacion
      t.string :tipo_pago
      t.string :estado
      t.belongs_to :usuario

      t.timestamps
    end
    add_index :pedidos, :usuario_id
  end
end
