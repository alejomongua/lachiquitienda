class AddFiltroToCampos < ActiveRecord::Migration
  def change
    add_column :campos_productos, :filtro, :boolean
  end
end
