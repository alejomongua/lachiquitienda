class CreateCamposProductos < ActiveRecord::Migration
  def change
    create_table :campos_productos do |t|
      t.string :nombre
      t.string :tipo_campo
      t.boolean :requerido
      t.belongs_to :categoria

      t.timestamps
    end
    add_index :campos_productos, :categoria_id
  end
end
