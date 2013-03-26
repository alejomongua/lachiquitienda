class AddDatosToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :direccion, :string
    add_column :usuarios, :ciudad, :string
    add_column :usuarios, :telefono, :string, limit: 20
  end
end
