class AddDestacadoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :destacado, :boolean
    add_index :productos, :destacado
    add_index :productos, :publicado
    add_index :productos, :created_at
  end
end
