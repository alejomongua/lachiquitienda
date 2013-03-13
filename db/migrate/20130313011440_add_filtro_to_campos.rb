class AddFiltroToCampos < ActiveRecord::Migration
  def change
    add_column :campos_productos, :filtro, :boolean
    add_column :campos_productos, :opcion, :boolean
  end
end
