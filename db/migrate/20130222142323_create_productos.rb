class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.belongs_to :categoria
      t.integer :precio

      t.timestamps
    end
    add_index :productos, :categoria_id
  end
end
