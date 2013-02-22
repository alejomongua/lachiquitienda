class AddPropiedadesToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :propiedades, :text
  end
end
