class CreateOpciones < ActiveRecord::Migration
  def change
    create_table :opciones do |t|
      t.string :nombre
      t.string :valor
      t.belongs_to :campo_producto

      t.timestamps
    end
    add_index :opciones, :campo_producto_id
  end
end
