class AddCantidadToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :cantidad, :integer
    add_column :productos, :publicado, :boolean
  end
end
